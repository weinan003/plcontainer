CREATE FUNCTION quote(t text, how text) RETURNS text AS $$
# container: plc_python_shared
    if how == "literal":
        return plpy.quote_literal(t)
    elif how == "nullable":
        return plpy.quote_nullable(t)
    elif how == "ident":
        return plpy.quote_ident(t)
    else:
        raise plpy.Error("unrecognized quote type %s" % how)
$$ LANGUAGE plcontainer;

SELECT quote(t, 'literal') FROM (VALUES
       ('abc'),
       ('a''bc'),
       ('''abc'''),
       (''),
       (''''),
       ('xyzv')) AS v(t);

SELECT quote(t, 'nullable') FROM (VALUES
       ('abc'),
       ('a''bc'),
       ('''abc'''),
       (''),
       (''''),
       (NULL)) AS v(t);

SELECT quote(t, 'ident') FROM (VALUES
       ('abc'),
       ('a b c'),
       ('a " ''abc''')) AS v(t);

