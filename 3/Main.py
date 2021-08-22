import mysql.connector as connector
from prettytable import PrettyTable

LINE = "***************************************************************************************"

connection = connector.connect(
    host='localhost', user='root', password='54peiman', database='dbproject', port='3306')
while True:
    arg = input("enter your args: ")
    argss = ""
    if (arg == 'break'):
        break
    args = arg.split()
    cursor = connection.cursor()
    if (args[0] == 'sign_in'):
        cursor.callproc('sign_in', args[1:])
    elif (args[0] == 'login'):
        cursor.callproc('userlogin', args[1:])
    elif (args[0] == "follow"):
        cursor.callproc('FollowingUser', args[1:])
    elif (args[0] == 'loginCheck'):
        cursor.callproc('UserLoginHistory', args[1:])
    elif (args[0] == 'unfollow'):
        cursor.callproc('Unfollow', args[1:])
    elif (args[0] == 'block'):
        cursor.callproc('blocked', args[1:])
    elif (args[0] == 'unblock'):
        cursor.callproc('unblock', args[1:])
    elif (args[0] == 'sendVoice'):
        for i in range(len(args) - 1):
            argss = argss + args[i + 1] + " "
        cursor.callproc('sendVoice', [argss])
    elif (args[0] == 'like'):
        cursor.callproc('Liking', args[1:])
    elif (args[0] == 'likers'):
        cursor.callproc('likers', args[1:])
    elif (args[0] == 'likersNumber'):
        cursor.callproc('likersNumber', args[1:])
    elif (args[0] == 'popularVoices'):
        cursor.callproc('PopularVoices')
    elif (args[0] == 'myVoices'):
        cursor.callproc('MyVoices')
    elif (args[0] == 'followingVoices'):
        cursor.callproc('followingVoices')
    elif (args[0] == 'addHashtag'):
        cursor.callproc('addTag', args[1:])
    elif (args[0] == 'getHashtag'):
        cursor.callproc('getHashtag', args[1:])
    elif (args[0] == 'reply'):
        for i in range(len(args) - 2):
            argss = argss + args[i + 2] + " "
        cursor.callproc('sendReply', [args[1], argss])
    elif (args[0] == 'getReply'):
        cursor.callproc('getReply', args[1:])
    elif (args[0] == 'getPost'):
        cursor.callproc('getPost', args[1:])
    elif (args[0] == 'message'):
        if args[2] == '1':
            cursor.callproc('SendMessage', [args[1], args[2], args[3], None])
        else:
            for i in range(len(args) - 3):
                argss = argss + args[i + 3] + " "
            cursor.callproc('SendMessage', [args[1], args[2], None, argss])
    elif (args[0] == 'getMessage'):
        cursor.callproc('getMessage', args[1:])
    elif (args[0] == 'getMessageSender'):
        cursor.callproc('getMessageSender')
    connection.commit()
    results = cursor.stored_results()
    myTable = None
    for result in results:
        field_names = [i[0] for i in result.description]
        myTable = PrettyTable(field_names)
        arr = result.fetchall()
        for row in arr:
            myTable.add_row([col for col in row])
        break

    for result in results:
        arr = result.fetchall()
        for row in arr:
            myTable.add_row([col for col in row])
    print(myTable)
    print(f"\n{LINE}\n")
