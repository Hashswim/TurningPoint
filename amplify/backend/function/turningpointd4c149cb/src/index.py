import json

stock_url_list = {
    '259960' : 'https://logo.clearbit.com/https://www.krafton.com',
    '263750' : 'https://logo.clearbit.com/https://www.pearlabyss.com'
}

stock_training_list = {
    '259960' : '크래프톤',
    '263750' : '펄어비스',
}

def handler(event, context):
    print('received event:')
    print(event)

    if event['eventType'] == "getLogo":
        return get_logo(event['code'])
    elif event['eventType'] == "getStockTrainingData":
        return get_stock_training_data(event['code'])
    elif event['eventType'] == "getAllTrainedList":
        return get_stock_training_list()
    elif event['eventType'] == "postSwitchTraining":
        return switch_training_state(event['code'])
    elif event['eventType'] == "getPredictedTransaction":
        return post_transaction(event['code'])
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

#get training data of stock
def get_stock_training_data(code):
    return
#    if hasModel(code) == false:
#        return {
#        'statusCode': 400,
#        'headers': {
#            'Access-Control-Allow-Headers': '*',
#            'Access-Control-Allow-Origin': '*',
#            'Access-Control-Allow-Methods': '*'
#        },
#        'body': json.dumps("false")}
#    else:
#        return {
#        'statusCode': 400,
#        'headers': {
#            'Access-Control-Allow-Headers': '*',
#            'Access-Control-Allow-Origin': '*',
#            'Access-Control-Allow-Methods': '*'
#        },
#        'body': json.dumps("{algorithm model list}")}


#get trained stocks
def get_stock_training_list():
    result = []

    for k, v in input_dict.items():
        result.append({'code': k, 'name': v})

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': json.dumps(result)}

#change training state
def switch_training_state(code):
    #change training state(start/end)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': json.dumps("complete")}

#post predicted transaction
def post_transaction(code):
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': json.dumps("{latest transaction}")}
