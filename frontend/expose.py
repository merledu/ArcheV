from frontend.index import analyze, llm_settings

def expose(window):
    window.expose(
        # utils
        llm_settings,
        analyze,
    )

