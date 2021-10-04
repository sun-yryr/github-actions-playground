#!/bin/bash

if [ ! $# -eq 12 ]; then
    echo '呼び出し失敗'
    exit 1
fi

# 引数取得
pipeline_name=$1
execution_id=$2

status=$(aws codepipeline get-pipeline-execution --pipeline-name "${pipeline_name}" --pipeline-execution-id "${execution_id}" \
            | jq -r '.pipelineExecution.status')

if [ "$status" = "InProgress" ]; then
    execution_id=$(aws codepipeline stop-pipeline-execution --pipeline-name "${pipeline_name}" --pipeline-execution-id "${execution_id}" \
                | jq -r '.pipelineExecutionId')
    echo "停止しました：${execution_id}"
fi
