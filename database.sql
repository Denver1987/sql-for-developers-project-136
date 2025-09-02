CREATE TABLE if not exists lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    content text,
    course_id bigint references courses(id),
    video_link text,
    -- squawk-ignore prefer-bigint-over-int
    position_in_course int,
    created_at date,
    updated_at date,
    course_link text
);

create table if not exists courses (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date
);

create table if not exists modules (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id bigint PRIMARY KEY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date
);

create table if not exists programs (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    price numeric not null,
    type text,
    created_at date,
    updated_at date
);