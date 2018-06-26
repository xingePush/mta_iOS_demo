/**
 *  @author xiangchen
 *  @version v0.1.0
 *  @date 2017-08-30 FBI JS SDK
 */

;(function (conf, global) {

    //初始化
    global.FBI = global.FBI || {};

    FBI._init = function (url) {
        var iframe = document.createElement("iframe");
        iframe.setAttribute("src", encodeURI(url));
        iframe.setAttribute("width", "0px");
        iframe.setAttribute("height", "0px");
        iframe.setAttribute("style", "display:none;");
        iframe.setAttribute("frameborder", "0");
        document.body.appendChild(iframe);
        iframe.parentNode.removeChild(iframe);
        iframe = null;
    }

    FBI.setupMTAWebViewJSBridge = function (callback) {
        if (window.MTAWebViewJSBridge) {
            return callback(MTAWebViewJSBridge);
        }
        if (window.WVJBCallbacks) {
            return window.WVJBCallbacks.push(callback);
        }
        window.WVJBCallbacks = [callback];
        var WVJBIframe = document.createElement('iframe');
        WVJBIframe.style.display = 'none';
        WVJBIframe.src = 'https://__mta_bridge_loaded__';
        document.documentElement.appendChild(WVJBIframe);
        setTimeout(function () {
            document.documentElement.removeChild(WVJBIframe)
        }, 0)
    }

    //上报
    FBI._report = function (funName, args) {
        var jsonStr = JSON.stringify(args);

        if (!!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)) {
            //iOS
            FBI.setupMTAWebViewJSBridge(function (bridge) {
                bridge.callHandler('jsreport', {
                    'funName': funName,
                    'jsonStr': jsonStr
                }, function responseCallback(responseData) {

                })
            })
        }
        else {
            //android
            var cmd = {
                methodName : funName,
                args : args
            };
            var jsonStr = JSON.stringify(cmd);
            var url = "tencentfbi:" + jsonStr;
            FBI._init(url);
        }
    }

    /**
     * 进入页面
     *
     * @param pageName 行为名称，参考 pageNames
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onEnteringPage = function (pageName, dictExtendInfo) {
        this._report("onEnteringPage", [pageName, dictExtendInfo]);
    }

    /**
     * 离开页面
     *
     * @param pageName 行为名称，参考 pageNames
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onLeavingPage = function (pageName, dictExtendInfo) {
        this._report("onLeavingPage", [pageName, dictExtendInfo]);
    }

    /**
     * 点击行为
     *
     * @param actionName 行为名称，参考 actionNames.click
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onClick = function (actionName, dictExtendInfo) {
        this._report("onClick", [actionName, dictExtendInfo]);
    }

    /**
     * 焦点变化
     *
     * @param actionName 行为名称，参考 actionNames.input
     * @param hasFocus   获得焦点
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onInputFocusChange = function (actionName, hasFocus, dictExtendInfo) {
        this._report("onInputFocusChange", [actionName, hasFocus, dictExtendInfo]);
    }

    /**
     * 文本内容变化
     *
     * @param actionName 行为名称，参考 actionNames.input
     * @param content    变化后的内容
     * @param needEncoding  是否需要编码  1:需要 0:不需要
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onInputContentChanged = function (actionName, content, needEncoding, dictExtendInfo) {
        this._report("onInputContentChanged", [actionName, content, needEncoding, dictExtendInfo]);
    }

    /**
     * 提交
     *
     * @param actionName   行为名称，参考 actionNames.submit
     * @param status       状态。 0：成功 1：失败
     * @param msg          成功或失败的描述
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onSubmit = function (actionName, status, msg, dictExtendInfo) {
        this._report("onSubmit", [actionName, status, msg, dictExtendInfo]);
    }

    /**
     * 登录成功
     *
     * @param loginMethod  登录方法，参考loginMethod
     * @param userID       用户登录的ID
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onLoginSuccess = function (loginMethod, userID, dictExtendInfo) {
        this._report("onLoginSuccess", ["LOGIN", loginMethod, userID, dictExtendInfo]);
    }

    /**
     * 注销操作
     *
     * @param dictExtendInfo 扩展数据, JS对象：对应一组kv键值对
     */
    FBI.onLogOut = function (dictExtendInfo) {
        this._report("onLoginOut", ["LOGOUT", dictExtendInfo])
    }

})({}, this);
