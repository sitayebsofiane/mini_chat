PGDMP     .    %                x        
   clientchat    12.1    12.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    43912 
   clientchat    DATABASE     �   CREATE DATABASE clientchat WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'French_France.1252' LC_CTYPE = 'French_France.1252';
    DROP DATABASE clientchat;
                postgres    false            �            1259    43946    messages    TABLE     �   CREATE TABLE public.messages (
    id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    users_id integer NOT NULL
);
    DROP TABLE public.messages;
       public         heap    postgres    false            �            1259    43944    messages_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.messages_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.messages_user_id_seq;
       public          postgres    false    205                       0    0    messages_user_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.messages_user_id_seq OWNED BY public.messages.id;
          public          postgres    false    204            �            1259    43927    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    pseudo character varying(20) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    43925    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    203                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    202            �
           2604    43949    messages id    DEFAULT     o   ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_user_id_seq'::regclass);
 :   ALTER TABLE public.messages ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204    205            �
           2604    43930    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202    203                      0    43946    messages 
   TABLE DATA           E   COPY public.messages (id, message, created_at, users_id) FROM stdin;
    public          postgres    false    205   �                 0    43927    users 
   TABLE DATA           <   COPY public.users (id, email, password, pseudo) FROM stdin;
    public          postgres    false    203   �                  0    0    messages_user_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.messages_user_id_seq', 1, false);
          public          postgres    false    204                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 2, true);
          public          postgres    false    202            �
           2606    43955    messages messages_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.messages DROP CONSTRAINT messages_pkey;
       public            postgres    false    205            �
           2606    43935    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    203            �
           2606    43956    messages users_message_id_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.messages
    ADD CONSTRAINT users_message_id_fkey FOREIGN KEY (id) REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.messages DROP CONSTRAINT users_message_id_fkey;
       public          postgres    false    205    2699    203                  x������ � �         �   x�M�M�0�����ki7KC])
���7�hC���Av��<��c4b�x�-�a��tl��c����y
KA����%���.��ȂnPC����$��MW���LѺ?Uٽ�_2:���<hUY<Ó��Fo��ǂc�a���OC�� ��8�     