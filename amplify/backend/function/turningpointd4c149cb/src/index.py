import json

stock_url_list = {
    '259960' : 'https://logo.clearbit.com/https://www.krafton.com',
    '263750' : 'https://logo.clearbit.com/https://www.pearlabyss.com',
    '005930' : 'https://logo.clearbit.com/https://www.samsung.com',
    '373220' : 'https://logo.clearbit.com/https://www.lgensol.com',
    '000660' : 'https://logo.clearbit.com/https://www.sk.co.kr',

    '207940' : 'https://logo.clearbit.com/https://samsungbiologics.com',
    '005490' : 'https://logo.clearbit.com/https://www.posco.co.kr',
    '005935' : 'https://logo.clearbit.com/https://www.samsung.com',
    '051910' : 'https://logo.clearbit.com/https://www.lgchem.com',
    '006400' : 'https://logo.clearbit.com/https://www.samsungsdi.co.kr',

    '005380' : 'https://logo.clearbit.com/https://www.hyundai.com',
    '003670' : 'https://logo.clearbit.com/http://www.posco.co.kr',
    '035420' : 'https://logo.clearbit.com/https://www.naver.com',
    '000270' : 'https://logo.clearbit.com/https://www.kia.com'
}

stock_training_list = {
    '259960' : '크래프톤',
    '263750' : '펄어비스',

    '005930' : '삼성전자',
    '373220' : 'LG에너지솔루션',
    '000660' : 'SK하이닉스',
    '207940' : '삼성바이오로직스',
    '005490' : 'POSCO홀딩스',

    '005935' : '삼성전자우',
    '051910' : 'LG화학',
    '006400' : '삼성SDI',
    '005380' : '현대차',
    '003670' : '포스코퓨처엠',

    '035420' : 'NAVER',
    '000270' : '기아',
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
    if code in stock_training_list:
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': '*'
            },
            'body': [
                {
                    'modelName' : 'modelName1',
                    'predictedProfit' : 5.1
                },
                {
                    'modelName' : 'modelName2',
                    'predictedProfit' : -2.4
                }
            ],
        }
    else:
        return {
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Headers': '*',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': '*'
            },
        }


#get trained stocks
def get_stock_training_list():
    code = []
    name = []

    for k, v in stock_training_list.items():
        code.append(k)
        name.append(v)

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*'
        },
        'body': {
            'code' : code,
            'name' : name
        }
    }

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
