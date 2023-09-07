import json

stock_url_list = {
    '259960' : 'https://logo.clearbit.com/https://www.krafton.com',
    '263750' : 'https://logo.clearbit.com/https://www.pearlabyss.com'
}

def handler(event, context):
    print('received event:')
    print(event)

    if event['eventType'] == "getLogo":
        return get_logo(event['code'])
    elif event['eventType'] == "getStockTrainingData":
        telecom = "KT"
    elif event['eventType'] == "getAllTrainedList":
        telecom = "LGU"
    elif event['eventType'] == "postSwitchTraining":
        telecom = "LGU"
    else:
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': '*'
            },
            'body': json.dumps(f"Given dictionary: {event}")}

#get logo
def get_logo(code):
    if code in stock_url_list:
        return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': json.dumps(stock_url_list[code])}
    else:
        return {
        'statusCode': 404,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': json.dumps("")}
