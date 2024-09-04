from frontend.index import analyze

def expose(window):
    window.expose(
        # utils
        analyze,
    )

