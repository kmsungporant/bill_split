from venmo_api import Client


def venmo_setup():
    global own_obj
    global venmo
    usrname = '*frontend input'
    psswrd = '*frontend input'

    access_token = Client.get_access_token(username=usrname, password=psswrd)
    print("My token:", access_token)

    venmo = Client(access_token=access_token)
    own_obj = venmo.user.get_my_profile()         #self user object

class make_friend():
    def __init__(self, name, pfp):
        self.name = name
        self.pfp = pfp


def venmo_friends():
    """
    Returns list of friends as objects (name, pfp)
    """
    global friends_list
    friends = venmo.user.get_user_friends_list(user = own_obj)
    friends_list =[]
    for friend in friends:
        obj = make_friend(name = friend.display_name , pfp = friend.profile_picture_url)
        friends_list.append(obj)
    return friends_list

def venmo_requests(amt, nte:str, friends_list):
    for friend in friends_list:
        venmo.payment.request_money(amount = amt, note=nte, target_user= friend)