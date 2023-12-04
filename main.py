from functools import partial
def my_func():
    print("asdasd")
def mine(m):
    print("sedon asd", m)

opts = {
    "1" : ("asd", (my_func, partial(mine, *"param"))),
    "2" : (
        "as", partial(mine)
    )
}
opts["2"][1]()

