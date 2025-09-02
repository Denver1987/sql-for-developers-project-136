create type program as enum ('Profession', 'Intensive', 'Test');
create type user_role as enum ('Student','Teacher', 'Admin');
create type enrollment_status as enum ('active', 'pending', 'cancelled', 'completed');
create type payments_status as enum ('pending', 'paid', 'failed', 'refunded');
create type prog_compl_status as enum ('active', 'completed', 'pending', 'cancelled');
create type blog_status as enum ('created', 'in moderation', 'published', 'archived');

CREATE TABLE IF NOT EXISTS courses(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    content text,
    course_id bigint REFERENCES courses(id),
    video_url text,
    -- squawk-ignore prefer-bigint-over-int
    position int,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS programs(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    price numeric NOT NULL,
    program_type program,
    created_at date,
    updated_at date
);

create table if not exists program_modules (
    program_id bigint not null REFERENCES programs(id),
    module_id bigint not null REFERENCES modules(id),
    PRIMARY KEY (program_id, module_id)
);

create table if not exists course_modules (
    module_id bigint not null REFERENCES modules(id),
    course_id bigint not null REFERENCES courses(id),
    PRIMARY KEY (module_id, course_id)
);

create table if not exists teaching_groups (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug text,
    created_at date,
    updated_at date
);

create table if not exists users (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text,
    email text,
    password_hash text,
    role user_role,
    teaching_group_id bigint REFERENCES teaching_groups(id),
    created_at date,
    updated_at date,
    deleted_at date
);

create table if not exists enrollments (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id bigint REFERENCES programs(id),
    status enrollment_status,
    user_id bigint REFERENCES users(id),
    created_at date,
    updated_at date
);

create table if not exists payments (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id bigint REFERENCES enrollments(id),
    amount numeric,
    paid_at timestamptz,
    status payments_status,
    updated_at timestamptz,
    created_at timestamptz    
);

create table if not exists program_completions (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    status prog_compl_status,
    started_at date,
    created_at date,
    updated_at date,
    completed_at date
);

create table if not exists certificates (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    program_id bigint REFERENCES programs(id),
    url text,
    created_at date,
    issued_at date,
    updated_at date
);

create table if not exists quizzes (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text,
    lesson_id bigint REFERENCES lessons(id),
    content jsonb,
    created_at date,
    updated_at date
);

create table if not exists exercises (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    name text,
    url text,
    created_at date,
    updated_at date
);

create table if not exists discussions (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id bigint REFERENCES lessons(id),
    user_id bigint REFERENCES users(id),
    text text,
    created_at date,
    updated_at date
);

create table if not exists blogs (
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id bigint REFERENCES users(id),
    name text,
    content jsonb,
    status blog_status,
    created_at date,
    updated_at date
);