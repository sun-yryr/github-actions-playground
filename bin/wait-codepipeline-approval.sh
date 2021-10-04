#!/bin/bash

# 指定したcodepipelineを実行して、完了するまで待つ。

if [ ! $# -eq 1 ]; then
    echo '呼び出し失敗'
    exit 1
fi

# 引数取得
pipeline_name=$1

# pipelineを実行する
execution_id=$(aws codepipeline start-pipeline-execution --name "${pipeline_name}" \
            | jq -r '.pipelineExecutionId')

echo "
次に進むためには下記のpipelineを承認してください。
pipeline name: ${pipeline_name}
execution id: ${execution_id}
"

status=""
# 空文字(最初) OR InProgress の時に繰り返す
while [ -z "$status" ] || [ "$status" = "InProgress" ]; do
    sleep 10
    # 現在の状況
    status=$(aws codepipeline get-pipeline-execution --pipeline-name "${pipeline_name}" --pipeline-execution-id "${execution_id}" \
            | jq -r '.pipelineExecution.status')

    now=$(date "+%Y-%m-%dT%H:%M:%S")

    echo "[${now}] 現在の状態： ${status}"
done

if [ "$status" = "Succeeded" ]; then
    echo "承認を確認しました"
    exit 0
elif [ "$status" = "Stopped" ]; then
    echo "停止されました"
    exit 1
elif [ "$status" = "Superseded" ]; then
    echo "後発のpipelineが優先されました"
    exit 1
else
    echo "想定外のステータスです"
    exit 1
fi
