<#if trigger == "success">
    <#assign message="${executionData.project} - <${executionData.href}|#${executionData.id}> Success">
</#if>
<#if trigger == "failure">
    <#assign message="${executionData.project} - <${executionData.href}|#${executionData.id}> Failure :cat-roomba-exceptionally-fast:">
</#if>
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#elseif trigger == "avgduration">
    <#assign state="Average exceeded">
<#elseif trigger == "retryablefailure">
    <#assign state="Retry Failure">
<#else>
    <#assign state="Succeeded">
</#if>

{
<#if channel??>
    "channel":"${channel}",
</#if>
    "attachments":[
        {
            "fallback":"${state}: ${message}",
            "pretext":"${message}",
            "color":"${color}",
            "fields":[
                {
                    "title":"Project",
                    "value":"${executionData.project}",
                    "short":true
                }
                ,{
                    "title":"Phase",
                    "value":"${executionData.job.group}",
                    "short":true
                }
                ,{
                    "title":"Job Name",
                    "value":"<${executionData.job.href}|${executionData.job.name}>",
                    "short":true
                }
                ,{
                    "title":"Started By",
                    "value":"&lt;@${executionData.user}&gt;",
                    "short":true
                }
                ,{
                    "title":"Execution ID",
                    "value":"<${executionData.href}|#${executionData.id}>",
                    "short":true
                }
<#if trigger == "success">
                ,{
                    "title":"Status",
                    "value":":smile:",
                    "short":true
                }
                ,{
                    "title":"Nodes",
                    "value":"${executionData.succeededNodeListString}",
                    "short":false
                }
</#if>
<#if trigger == "failure">
                ,{
                    "title":"Status",
                    "value":":x:",
                    "short":true
                }
                ,{
                    "title":"Failed Nodes",
                    "value":"${executionData.failedNodeListString}",
                    "short":false
                }
</#if>
            ]
        }
    ]
}
