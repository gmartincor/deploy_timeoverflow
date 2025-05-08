-- Activar la extensión unaccent
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Reemplazar la función trigger para que funcione correctamente
CREATE OR REPLACE FUNCTION public.posts_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      new.tsv :=
        to_tsvector('simple', unaccent(coalesce(new.title::text, ''))) ||
        to_tsvector('simple', unaccent(coalesce(new.description::text, ''))) ||
        to_tsvector('simple', unaccent(coalesce(new.tags::text, '')));
      RETURN new;
    END;
    $$;
