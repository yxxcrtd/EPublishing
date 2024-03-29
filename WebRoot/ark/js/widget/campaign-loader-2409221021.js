!function() {
    function providePlugin(pluginName, pluginConstructor) {
        var ga = window[window.GoogleAnalyticsObject || "ga"];
        ga && ga("provide", pluginName, pluginConstructor)
    }
    var rNonQuerystring = /\+/g, utils = {deparam: function(string) {
            for (var params = {}, paramsArray = string.replace(rNonQuerystring, " ").split("&"), i = 0, l = paramsArray.length; l > i; i++) {
                var paramString = paramsArray[i], pair = paramString.split("="), paramName = decodeURIComponent([pair[0]]), paramValue = decodeURIComponent([pair[1]]);
                params[paramName] = paramValue
            }
            return params
        },isUndefined: function(obj) {
            return void 0 === obj
        }}, trackingSources = {dcn: "campaignName",dcs: "campaignSource",dcm: "campaignMedium",dcc: "campaignContent",dct: "campaignKeyword"}, CampaignLoader = function(tracker, config) {
        this.tracker = tracker, this.isDebug = config.debug
    };
    CampaignLoader.prototype.loadCampaignFields = function() {
        var params = utils.deparam(window.location.search.replace("?", ""));
        for (var customKey in trackingSources)
            if (!utils.isUndefined(params[customKey])) {
                var nameKey = trackingSources[customKey], nameValue = params[customKey];
                this.tracker.set(nameKey, nameValue), this.debugMessage("Loaded campaign name: " + nameKey + " value: " + nameValue)
            }
    }, CampaignLoader.prototype.setDebug = function(enabled) {
        this.isDebug = enabled
    }, CampaignLoader.prototype.debugMessage = function(message) {
        this.isDebug && console && console.debug(message)
    }, providePlugin("campaignLoader", CampaignLoader)
}();
