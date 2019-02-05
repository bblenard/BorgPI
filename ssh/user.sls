{% import_yaml "vars.yaml" as vars %}
{% for user, keys in vars.authorized_keys.iteritems() %}
Install authorized_keys file for {{ user }}:
    ssh_auth.present:
        - user: {{ user }}
        - names:
        {% for key in keys %}
            - {{ key }}
        {% endfor %}
{% endfor %}
