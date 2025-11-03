def genera_badge_svg(nodo_id, hash_value):
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="300" height="100">
  <rect width="300" height="100" fill="#0f0f0f"/>
  <text x="10" y="30" fill="#00ffcc" font-size="16">XR∞ Node: {nodo_id}</text>
  <text x="10" y="60" fill="#ffffff" font-size="12">Hash: {hash_value[:16]}...</text>
</svg>'''
    with open("sigillo_badge.svg", "w") as f:
        f.write(svg)
