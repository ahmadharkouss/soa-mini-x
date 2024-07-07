--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
df17ed78-2177-4bb0-8115-8753b10e25b3	aa9e7b0e-f4a7-4e0d-a3dd-8c5c75ce8bf1
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
bea4660d-a8cb-4ed8-89de-df00792d16b6	\N	auth-cookie	2eca1426-cce8-48c4-a944-90aa859476ff	d8ca3361-b58a-4b80-a876-b11c4e4872bd	2	10	f	\N	\N
28cf7193-6c74-4f8a-9732-d3216de9f982	\N	auth-spnego	2eca1426-cce8-48c4-a944-90aa859476ff	d8ca3361-b58a-4b80-a876-b11c4e4872bd	3	20	f	\N	\N
e7abcd3a-4233-4cff-b2bd-019aa18e155f	\N	identity-provider-redirector	2eca1426-cce8-48c4-a944-90aa859476ff	d8ca3361-b58a-4b80-a876-b11c4e4872bd	2	25	f	\N	\N
ae8c2f9a-6604-4505-b80b-31324e444647	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	d8ca3361-b58a-4b80-a876-b11c4e4872bd	2	30	t	10ce1cb3-f4da-4f7b-80af-ffd92df45ea5	\N
a24aca63-78a1-4f81-acbd-8f09dc2732cb	\N	auth-username-password-form	2eca1426-cce8-48c4-a944-90aa859476ff	10ce1cb3-f4da-4f7b-80af-ffd92df45ea5	0	10	f	\N	\N
d9f76473-24c9-4d03-9653-52d4e26e222f	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	10ce1cb3-f4da-4f7b-80af-ffd92df45ea5	1	20	t	2e161824-7740-4542-9546-35d3c6a196d7	\N
96e6c719-10a6-4338-a4ca-7e0bf6111d38	\N	conditional-user-configured	2eca1426-cce8-48c4-a944-90aa859476ff	2e161824-7740-4542-9546-35d3c6a196d7	0	10	f	\N	\N
5b0560bc-b06d-49b6-8fd1-12f8c27916c0	\N	auth-otp-form	2eca1426-cce8-48c4-a944-90aa859476ff	2e161824-7740-4542-9546-35d3c6a196d7	0	20	f	\N	\N
0e497783-ad77-45b7-996c-c50aa899b45f	\N	direct-grant-validate-username	2eca1426-cce8-48c4-a944-90aa859476ff	b2c5494e-eb3b-4976-a1cf-d43e4c425a82	0	10	f	\N	\N
a90644df-2383-49ff-9428-3dc8fb9bd7dc	\N	direct-grant-validate-password	2eca1426-cce8-48c4-a944-90aa859476ff	b2c5494e-eb3b-4976-a1cf-d43e4c425a82	0	20	f	\N	\N
50243e92-66f6-4b24-b564-fcfd9e45e135	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	b2c5494e-eb3b-4976-a1cf-d43e4c425a82	1	30	t	52ccada2-8927-4816-9497-88acb3c0b31b	\N
17bb5dd0-3d62-4ad6-ac92-4841cddf8e65	\N	conditional-user-configured	2eca1426-cce8-48c4-a944-90aa859476ff	52ccada2-8927-4816-9497-88acb3c0b31b	0	10	f	\N	\N
85fac465-3f35-424e-b2a3-f5013c03ec21	\N	direct-grant-validate-otp	2eca1426-cce8-48c4-a944-90aa859476ff	52ccada2-8927-4816-9497-88acb3c0b31b	0	20	f	\N	\N
7f40de78-fb32-4b85-b242-6ebd8edf2d25	\N	registration-page-form	2eca1426-cce8-48c4-a944-90aa859476ff	baa452eb-29d8-450a-b70f-534a841d5fc4	0	10	t	040cfdb7-00d5-40a2-a95e-96612c72e0f0	\N
f75739fa-48e5-454a-96de-34d7a1f7ea20	\N	registration-user-creation	2eca1426-cce8-48c4-a944-90aa859476ff	040cfdb7-00d5-40a2-a95e-96612c72e0f0	0	20	f	\N	\N
4e7330a3-7330-4cdd-aafe-f0d62ecdcdaa	\N	registration-password-action	2eca1426-cce8-48c4-a944-90aa859476ff	040cfdb7-00d5-40a2-a95e-96612c72e0f0	0	50	f	\N	\N
4fae94dd-4733-4fcf-9616-962b0c982f03	\N	registration-recaptcha-action	2eca1426-cce8-48c4-a944-90aa859476ff	040cfdb7-00d5-40a2-a95e-96612c72e0f0	3	60	f	\N	\N
d7a78fcd-48ba-4dab-bb60-96a4a26fd737	\N	registration-terms-and-conditions	2eca1426-cce8-48c4-a944-90aa859476ff	040cfdb7-00d5-40a2-a95e-96612c72e0f0	3	70	f	\N	\N
c4d4574c-a131-4c80-a5f5-632f7680a5c9	\N	reset-credentials-choose-user	2eca1426-cce8-48c4-a944-90aa859476ff	8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	0	10	f	\N	\N
c25db2b5-6353-4a1c-8355-1a50afdcd623	\N	reset-credential-email	2eca1426-cce8-48c4-a944-90aa859476ff	8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	0	20	f	\N	\N
b635363d-5564-4609-8ee4-6d30ab340396	\N	reset-password	2eca1426-cce8-48c4-a944-90aa859476ff	8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	0	30	f	\N	\N
5ec3a2e7-6023-43a9-b355-d5836d964f0d	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	1	40	t	a8d5babd-15de-4b18-ba3e-f1f39e3eeda3	\N
9574e58a-e970-47ce-9b20-2524ccbdebd4	\N	conditional-user-configured	2eca1426-cce8-48c4-a944-90aa859476ff	a8d5babd-15de-4b18-ba3e-f1f39e3eeda3	0	10	f	\N	\N
dd14eb94-e256-439e-84c9-df63a8f664a9	\N	reset-otp	2eca1426-cce8-48c4-a944-90aa859476ff	a8d5babd-15de-4b18-ba3e-f1f39e3eeda3	0	20	f	\N	\N
5c39f022-04db-40a5-9d55-bd9a079a575f	\N	client-secret	2eca1426-cce8-48c4-a944-90aa859476ff	85038df2-2b44-48c4-a975-ee9fa62be024	2	10	f	\N	\N
240ec907-7274-43a3-a675-ee0cf816a3b2	\N	client-jwt	2eca1426-cce8-48c4-a944-90aa859476ff	85038df2-2b44-48c4-a975-ee9fa62be024	2	20	f	\N	\N
dbc71005-5905-41d8-89e3-ca63a060f129	\N	client-secret-jwt	2eca1426-cce8-48c4-a944-90aa859476ff	85038df2-2b44-48c4-a975-ee9fa62be024	2	30	f	\N	\N
934515b4-c39c-4dc0-b80a-2d1e6dbeae96	\N	client-x509	2eca1426-cce8-48c4-a944-90aa859476ff	85038df2-2b44-48c4-a975-ee9fa62be024	2	40	f	\N	\N
ab17ab75-7f79-4bc3-b80f-aa140e55a502	\N	idp-review-profile	2eca1426-cce8-48c4-a944-90aa859476ff	9b45498c-8f3e-4dda-8914-bcad5046b6a5	0	10	f	\N	19e33626-b871-4e78-98ee-73890b03d293
f84d2cd7-b5df-4307-825f-ea47fede9189	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	9b45498c-8f3e-4dda-8914-bcad5046b6a5	0	20	t	f049e1d2-000d-4cf3-ac82-3b7cc432e9b6	\N
0ed60c52-7bf3-442c-b838-38dbac110beb	\N	idp-create-user-if-unique	2eca1426-cce8-48c4-a944-90aa859476ff	f049e1d2-000d-4cf3-ac82-3b7cc432e9b6	2	10	f	\N	a8772d54-adca-482f-a29d-412e200612ab
e7322364-8203-4dc8-9760-7a2c33a0ff71	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	f049e1d2-000d-4cf3-ac82-3b7cc432e9b6	2	20	t	e3eab508-597d-4113-9261-d3cd086f0eef	\N
b46efb0a-648d-40ec-8ad2-e73bed794cd2	\N	idp-confirm-link	2eca1426-cce8-48c4-a944-90aa859476ff	e3eab508-597d-4113-9261-d3cd086f0eef	0	10	f	\N	\N
1c1951f7-5ba5-4565-b8df-c1ab138d1185	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	e3eab508-597d-4113-9261-d3cd086f0eef	0	20	t	a847a08c-4882-4112-85bd-9db2da2cc1f9	\N
708932d7-4f8c-4f72-97b3-00ed4df7daff	\N	idp-email-verification	2eca1426-cce8-48c4-a944-90aa859476ff	a847a08c-4882-4112-85bd-9db2da2cc1f9	2	10	f	\N	\N
cab2016b-676e-4400-bf56-c58518b5efa1	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	a847a08c-4882-4112-85bd-9db2da2cc1f9	2	20	t	bcf09b7c-852f-4237-932c-121cde00da0c	\N
80196f90-cb36-45a0-9fd5-8af59a8db356	\N	idp-username-password-form	2eca1426-cce8-48c4-a944-90aa859476ff	bcf09b7c-852f-4237-932c-121cde00da0c	0	10	f	\N	\N
a1d3443d-8620-4429-96a8-183b8f80b25f	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	bcf09b7c-852f-4237-932c-121cde00da0c	1	20	t	3b468372-cb15-4449-b0ad-c0ae0697e39e	\N
65e268c1-48cc-4f14-9ce0-246752f859a5	\N	conditional-user-configured	2eca1426-cce8-48c4-a944-90aa859476ff	3b468372-cb15-4449-b0ad-c0ae0697e39e	0	10	f	\N	\N
ed189111-dcbb-4dcf-9752-69cb6dcff1fd	\N	auth-otp-form	2eca1426-cce8-48c4-a944-90aa859476ff	3b468372-cb15-4449-b0ad-c0ae0697e39e	0	20	f	\N	\N
7ffb87e5-36e2-478a-ba21-e5fda85a8993	\N	http-basic-authenticator	2eca1426-cce8-48c4-a944-90aa859476ff	8529a486-86d9-478f-bed4-7c901652b089	0	10	f	\N	\N
13d5471d-fd1a-4cba-a80f-a9267757febf	\N	docker-http-basic-authenticator	2eca1426-cce8-48c4-a944-90aa859476ff	40087af9-532e-4861-86ac-e88abda1bc6c	0	10	f	\N	\N
b73c9a88-8e50-4413-84e4-b974466df2a4	\N	auth-cookie	00164430-588c-4b7e-a550-cedd315756a4	4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	2	10	f	\N	\N
aead6115-6956-4240-ac14-f008fac11d4a	\N	auth-spnego	00164430-588c-4b7e-a550-cedd315756a4	4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	3	20	f	\N	\N
4e9f5a1c-93a5-4de1-8164-abf26742505b	\N	identity-provider-redirector	00164430-588c-4b7e-a550-cedd315756a4	4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	2	25	f	\N	\N
07c49394-5e17-46b0-8b83-287cb59f7091	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	2	30	t	31dd33c2-5787-486c-b83b-4bbf98423bba	\N
c88bb24a-4989-4f14-a21a-371bd85278b7	\N	auth-username-password-form	00164430-588c-4b7e-a550-cedd315756a4	31dd33c2-5787-486c-b83b-4bbf98423bba	0	10	f	\N	\N
e474ab05-a772-4a4c-a4a8-ff1545e62b3e	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	31dd33c2-5787-486c-b83b-4bbf98423bba	1	20	t	5c36b59c-942e-4c68-92a8-016a369de05a	\N
982b02d6-687f-4c33-a9e4-0b3a7525c7e9	\N	conditional-user-configured	00164430-588c-4b7e-a550-cedd315756a4	5c36b59c-942e-4c68-92a8-016a369de05a	0	10	f	\N	\N
1b1c4810-2bbf-4fec-8e54-79b0ed0a661d	\N	auth-otp-form	00164430-588c-4b7e-a550-cedd315756a4	5c36b59c-942e-4c68-92a8-016a369de05a	0	20	f	\N	\N
046af966-a5fe-478f-a7ef-e255c7a1ee78	\N	direct-grant-validate-username	00164430-588c-4b7e-a550-cedd315756a4	4aa8d267-6540-4d79-8269-462c2f3a9edc	0	10	f	\N	\N
e97be078-474d-46ad-b38b-eb6f8dde27b4	\N	direct-grant-validate-password	00164430-588c-4b7e-a550-cedd315756a4	4aa8d267-6540-4d79-8269-462c2f3a9edc	0	20	f	\N	\N
ba814dc1-664f-4b12-8fd4-7b868718ae8b	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	4aa8d267-6540-4d79-8269-462c2f3a9edc	1	30	t	7b04e4db-637b-4e8b-b061-850c8cff322b	\N
3e57746c-2e5e-4592-b677-5acaeaece4ed	\N	conditional-user-configured	00164430-588c-4b7e-a550-cedd315756a4	7b04e4db-637b-4e8b-b061-850c8cff322b	0	10	f	\N	\N
e266dd9b-59c0-4f34-8b18-c663f32a103a	\N	direct-grant-validate-otp	00164430-588c-4b7e-a550-cedd315756a4	7b04e4db-637b-4e8b-b061-850c8cff322b	0	20	f	\N	\N
6834f91a-ae98-4324-a1b6-0e07fdc578bf	\N	registration-page-form	00164430-588c-4b7e-a550-cedd315756a4	4e1c229f-b8e4-4bc1-a620-92961a47b0da	0	10	t	095f775d-70ee-431d-8898-08b1ff0f3150	\N
192447ac-2bbd-4480-a1df-7307bb7b0f89	\N	registration-user-creation	00164430-588c-4b7e-a550-cedd315756a4	095f775d-70ee-431d-8898-08b1ff0f3150	0	20	f	\N	\N
80cca885-8be1-4571-b655-f9d6dea86d40	\N	registration-password-action	00164430-588c-4b7e-a550-cedd315756a4	095f775d-70ee-431d-8898-08b1ff0f3150	0	50	f	\N	\N
c330a352-7c59-4890-9cdf-39dd78e7de3c	\N	registration-recaptcha-action	00164430-588c-4b7e-a550-cedd315756a4	095f775d-70ee-431d-8898-08b1ff0f3150	3	60	f	\N	\N
144416ea-7c71-4030-9642-7189426c0ca2	\N	registration-terms-and-conditions	00164430-588c-4b7e-a550-cedd315756a4	095f775d-70ee-431d-8898-08b1ff0f3150	3	70	f	\N	\N
82268042-39e8-4742-b238-72b8d0431aa9	\N	reset-credentials-choose-user	00164430-588c-4b7e-a550-cedd315756a4	202006e2-9717-44b9-8368-3aa0e29df77b	0	10	f	\N	\N
0ec9b228-2d6c-4f37-9b8d-448524a5b8ad	\N	reset-credential-email	00164430-588c-4b7e-a550-cedd315756a4	202006e2-9717-44b9-8368-3aa0e29df77b	0	20	f	\N	\N
05cacdee-39e6-43e5-9b35-defcf8289412	\N	reset-password	00164430-588c-4b7e-a550-cedd315756a4	202006e2-9717-44b9-8368-3aa0e29df77b	0	30	f	\N	\N
fdef55a1-94b2-455b-9dfa-77b7ab63d064	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	202006e2-9717-44b9-8368-3aa0e29df77b	1	40	t	6f7d8815-b347-4197-8c17-fcf5133fa510	\N
a48911e8-5b79-403c-aece-23c5f97c8a92	\N	conditional-user-configured	00164430-588c-4b7e-a550-cedd315756a4	6f7d8815-b347-4197-8c17-fcf5133fa510	0	10	f	\N	\N
9acc9c43-c255-4f7c-9492-5de90b65ac1b	\N	reset-otp	00164430-588c-4b7e-a550-cedd315756a4	6f7d8815-b347-4197-8c17-fcf5133fa510	0	20	f	\N	\N
e94721a6-4fed-49fc-a37c-e13a68d03c7e	\N	client-secret	00164430-588c-4b7e-a550-cedd315756a4	8faaf973-b6d8-4bbd-a766-02f9a3903fc6	2	10	f	\N	\N
548f2185-e338-4d9a-94b5-70ddf2cfe763	\N	client-jwt	00164430-588c-4b7e-a550-cedd315756a4	8faaf973-b6d8-4bbd-a766-02f9a3903fc6	2	20	f	\N	\N
efa5b675-c01f-47ea-9410-7465ae35e0d8	\N	client-secret-jwt	00164430-588c-4b7e-a550-cedd315756a4	8faaf973-b6d8-4bbd-a766-02f9a3903fc6	2	30	f	\N	\N
1b72f2ad-b700-4877-b730-506656553b3a	\N	client-x509	00164430-588c-4b7e-a550-cedd315756a4	8faaf973-b6d8-4bbd-a766-02f9a3903fc6	2	40	f	\N	\N
9dff74f9-f52a-4043-be25-896380d2f4f4	\N	idp-review-profile	00164430-588c-4b7e-a550-cedd315756a4	fc6f9e4e-b244-416f-ac2c-ffd1400acf4b	0	10	f	\N	84efdf0c-ca9d-400e-96f0-2c0da7622b5e
3a58b4bd-29f1-4d21-bd2c-a60d13428a4c	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	fc6f9e4e-b244-416f-ac2c-ffd1400acf4b	0	20	t	03e2bfca-e4d9-46a3-a3b7-d231fc216a42	\N
c75078f6-a99d-4709-966c-b60330420e31	\N	idp-create-user-if-unique	00164430-588c-4b7e-a550-cedd315756a4	03e2bfca-e4d9-46a3-a3b7-d231fc216a42	2	10	f	\N	d0de6139-efe7-4520-bb50-6dee124b77a8
19240caa-4b2c-4219-a40b-7825595be29e	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	03e2bfca-e4d9-46a3-a3b7-d231fc216a42	2	20	t	5de4bce1-99db-45d1-95e1-7ca8d68d9956	\N
d60f659d-42ac-4e73-a349-b4b5d036dd67	\N	idp-confirm-link	00164430-588c-4b7e-a550-cedd315756a4	5de4bce1-99db-45d1-95e1-7ca8d68d9956	0	10	f	\N	\N
8c8fea98-451e-41f7-8b19-6a10b1d5a080	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	5de4bce1-99db-45d1-95e1-7ca8d68d9956	0	20	t	68aebbd6-d360-4df5-8364-812ffbed7a70	\N
8f41647a-cd1b-4d28-a333-babca227a90b	\N	idp-email-verification	00164430-588c-4b7e-a550-cedd315756a4	68aebbd6-d360-4df5-8364-812ffbed7a70	2	10	f	\N	\N
dfdfc65d-3671-418f-9029-c1749dbeebb1	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	68aebbd6-d360-4df5-8364-812ffbed7a70	2	20	t	99f0a727-02d6-455a-86f9-5a73c044b80a	\N
92c496ad-252d-4727-9c94-c9f3cee71188	\N	idp-username-password-form	00164430-588c-4b7e-a550-cedd315756a4	99f0a727-02d6-455a-86f9-5a73c044b80a	0	10	f	\N	\N
3fbefbc9-75fb-49a4-b9c0-b2e86955f0be	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	99f0a727-02d6-455a-86f9-5a73c044b80a	1	20	t	41108b2c-b7c4-4217-9360-cf886516fa2e	\N
988a6b16-6a68-4a6e-b614-39cf59cdbd1c	\N	conditional-user-configured	00164430-588c-4b7e-a550-cedd315756a4	41108b2c-b7c4-4217-9360-cf886516fa2e	0	10	f	\N	\N
4bfb0d3c-2d2e-444f-91e6-1ae17508bab6	\N	auth-otp-form	00164430-588c-4b7e-a550-cedd315756a4	41108b2c-b7c4-4217-9360-cf886516fa2e	0	20	f	\N	\N
5d99dab4-7143-4a67-98f5-7a7bca68253e	\N	http-basic-authenticator	00164430-588c-4b7e-a550-cedd315756a4	59870351-511f-4eb7-be49-94bcdfc0657f	0	10	f	\N	\N
91fde383-f951-405d-ab24-9c4390dfa451	\N	docker-http-basic-authenticator	00164430-588c-4b7e-a550-cedd315756a4	bc848b48-96ae-4a0a-92b9-07c3f02b9f11	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
d8ca3361-b58a-4b80-a876-b11c4e4872bd	browser	browser based authentication	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
10ce1cb3-f4da-4f7b-80af-ffd92df45ea5	forms	Username, password, otp and other auth forms.	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
2e161824-7740-4542-9546-35d3c6a196d7	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
b2c5494e-eb3b-4976-a1cf-d43e4c425a82	direct grant	OpenID Connect Resource Owner Grant	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
52ccada2-8927-4816-9497-88acb3c0b31b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
baa452eb-29d8-450a-b70f-534a841d5fc4	registration	registration flow	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
040cfdb7-00d5-40a2-a95e-96612c72e0f0	registration form	registration form	2eca1426-cce8-48c4-a944-90aa859476ff	form-flow	f	t
8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	reset credentials	Reset credentials for a user if they forgot their password or something	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
a8d5babd-15de-4b18-ba3e-f1f39e3eeda3	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
85038df2-2b44-48c4-a975-ee9fa62be024	clients	Base authentication for clients	2eca1426-cce8-48c4-a944-90aa859476ff	client-flow	t	t
9b45498c-8f3e-4dda-8914-bcad5046b6a5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
f049e1d2-000d-4cf3-ac82-3b7cc432e9b6	User creation or linking	Flow for the existing/non-existing user alternatives	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
e3eab508-597d-4113-9261-d3cd086f0eef	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
a847a08c-4882-4112-85bd-9db2da2cc1f9	Account verification options	Method with which to verity the existing account	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
bcf09b7c-852f-4237-932c-121cde00da0c	Verify Existing Account by Re-authentication	Reauthentication of existing account	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
3b468372-cb15-4449-b0ad-c0ae0697e39e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	f	t
8529a486-86d9-478f-bed4-7c901652b089	saml ecp	SAML ECP Profile Authentication Flow	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
40087af9-532e-4861-86ac-e88abda1bc6c	docker auth	Used by Docker clients to authenticate against the IDP	2eca1426-cce8-48c4-a944-90aa859476ff	basic-flow	t	t
4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	browser	browser based authentication	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
31dd33c2-5787-486c-b83b-4bbf98423bba	forms	Username, password, otp and other auth forms.	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
5c36b59c-942e-4c68-92a8-016a369de05a	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
4aa8d267-6540-4d79-8269-462c2f3a9edc	direct grant	OpenID Connect Resource Owner Grant	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
7b04e4db-637b-4e8b-b061-850c8cff322b	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
4e1c229f-b8e4-4bc1-a620-92961a47b0da	registration	registration flow	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
095f775d-70ee-431d-8898-08b1ff0f3150	registration form	registration form	00164430-588c-4b7e-a550-cedd315756a4	form-flow	f	t
202006e2-9717-44b9-8368-3aa0e29df77b	reset credentials	Reset credentials for a user if they forgot their password or something	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
6f7d8815-b347-4197-8c17-fcf5133fa510	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
8faaf973-b6d8-4bbd-a766-02f9a3903fc6	clients	Base authentication for clients	00164430-588c-4b7e-a550-cedd315756a4	client-flow	t	t
fc6f9e4e-b244-416f-ac2c-ffd1400acf4b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
03e2bfca-e4d9-46a3-a3b7-d231fc216a42	User creation or linking	Flow for the existing/non-existing user alternatives	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
5de4bce1-99db-45d1-95e1-7ca8d68d9956	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
68aebbd6-d360-4df5-8364-812ffbed7a70	Account verification options	Method with which to verity the existing account	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
99f0a727-02d6-455a-86f9-5a73c044b80a	Verify Existing Account by Re-authentication	Reauthentication of existing account	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
41108b2c-b7c4-4217-9360-cf886516fa2e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	f	t
59870351-511f-4eb7-be49-94bcdfc0657f	saml ecp	SAML ECP Profile Authentication Flow	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
bc848b48-96ae-4a0a-92b9-07c3f02b9f11	docker auth	Used by Docker clients to authenticate against the IDP	00164430-588c-4b7e-a550-cedd315756a4	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
19e33626-b871-4e78-98ee-73890b03d293	review profile config	2eca1426-cce8-48c4-a944-90aa859476ff
a8772d54-adca-482f-a29d-412e200612ab	create unique user config	2eca1426-cce8-48c4-a944-90aa859476ff
84efdf0c-ca9d-400e-96f0-2c0da7622b5e	review profile config	00164430-588c-4b7e-a550-cedd315756a4
d0de6139-efe7-4520-bb50-6dee124b77a8	create unique user config	00164430-588c-4b7e-a550-cedd315756a4
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
19e33626-b871-4e78-98ee-73890b03d293	missing	update.profile.on.first.login
a8772d54-adca-482f-a29d-412e200612ab	false	require.password.update.after.registration
84efdf0c-ca9d-400e-96f0-2c0da7622b5e	missing	update.profile.on.first.login
d0de6139-efe7-4520-bb50-6dee124b77a8	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
6d49f9d7-5c39-403e-8651-b349982997c6	t	f	master-realm	0	f	\N	\N	t	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d4b85b39-6674-433d-844b-6a8d39d8ecce	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
eb2f3da9-5568-446b-a1eb-0a05c8987d19	t	f	broker	0	f	\N	\N	t	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
83d065c1-c30e-4b10-8e1d-399a201d4805	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
18d9b379-5d67-47f0-9a46-2909fbd01344	t	f	admin-cli	0	t	\N	\N	f	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3e84fc6e-f844-432d-b205-1bd1b8255474	t	f	apache-realm-realm	0	f	\N	\N	t	\N	f	2eca1426-cce8-48c4-a944-90aa859476ff	\N	0	f	f	apache-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
75041075-d112-404a-ad59-16fae2dbb663	t	f	realm-management	0	f	\N	\N	t	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
d2900d29-9eee-4985-b398-9b1d9908b742	t	f	account	0	t	\N	/realms/apache-realm/account/	f	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6eed25a6-533d-42d1-a2b7-385062550518	t	f	account-console	0	t	\N	/realms/apache-realm/account/	f	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	t	f	broker	0	f	\N	\N	t	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
33a02fbc-ce94-41de-bea8-afedd6f6b780	t	f	security-admin-console	0	t	\N	/admin/apache-realm/console/	f	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	t	f	admin-cli	0	t	\N	\N	f	\N	f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
305eeea6-c469-4d38-a79b-df23ef9f25da	t	t	apache	0	f	Jm4Kt9ss7E9Kj9IARQRQrUOidP2B2Rx4	https://x.devgains.com/private	f		f	00164430-588c-4b7e-a550-cedd315756a4	openid-connect	-1	t	f		t	client-secret	https://x.devgains.com/		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
c1e8118b-364d-422d-93f6-03d6e6ef9feb	post.logout.redirect.uris	+
d4b85b39-6674-433d-844b-6a8d39d8ecce	post.logout.redirect.uris	+
d4b85b39-6674-433d-844b-6a8d39d8ecce	pkce.code.challenge.method	S256
83d065c1-c30e-4b10-8e1d-399a201d4805	post.logout.redirect.uris	+
83d065c1-c30e-4b10-8e1d-399a201d4805	pkce.code.challenge.method	S256
d2900d29-9eee-4985-b398-9b1d9908b742	post.logout.redirect.uris	+
6eed25a6-533d-42d1-a2b7-385062550518	post.logout.redirect.uris	+
6eed25a6-533d-42d1-a2b7-385062550518	pkce.code.challenge.method	S256
33a02fbc-ce94-41de-bea8-afedd6f6b780	post.logout.redirect.uris	+
33a02fbc-ce94-41de-bea8-afedd6f6b780	pkce.code.challenge.method	S256
305eeea6-c469-4d38-a79b-df23ef9f25da	client.secret.creation.time	1720094488
305eeea6-c469-4d38-a79b-df23ef9f25da	oauth2.device.authorization.grant.enabled	false
305eeea6-c469-4d38-a79b-df23ef9f25da	oidc.ciba.grant.enabled	false
305eeea6-c469-4d38-a79b-df23ef9f25da	backchannel.logout.session.required	true
305eeea6-c469-4d38-a79b-df23ef9f25da	backchannel.logout.revoke.offline.tokens	false
305eeea6-c469-4d38-a79b-df23ef9f25da	display.on.consent.screen	false
305eeea6-c469-4d38-a79b-df23ef9f25da	post.logout.redirect.uris	+
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
3933f10c-2bee-47ef-8fc2-19c3939753ab	offline_access	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect built-in scope: offline_access	openid-connect
10651b1e-f454-4a13-8519-8c102b3d94db	role_list	2eca1426-cce8-48c4-a944-90aa859476ff	SAML role list	saml
c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	profile	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect built-in scope: profile	openid-connect
f13d8b38-140f-4d5f-88fb-a07b008ea6c5	email	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect built-in scope: email	openid-connect
070f9656-1da4-4dba-bb7f-479f1d3cbec5	address	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect built-in scope: address	openid-connect
d92fbce2-8e26-439e-9cc3-bdc7d5886160	phone	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect built-in scope: phone	openid-connect
1268d73b-8909-4d13-ba86-b37057d7f220	roles	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect scope for add user roles to the access token	openid-connect
68d802c9-9b18-45dd-87d2-873e1bf4915f	web-origins	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect scope for add allowed web origins to the access token	openid-connect
410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	microprofile-jwt	2eca1426-cce8-48c4-a944-90aa859476ff	Microprofile - JWT built-in scope	openid-connect
a4da603e-292f-48e3-a837-0f766babe061	acr	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
53a294d3-c294-4e23-be32-ffc0919802b9	basic	2eca1426-cce8-48c4-a944-90aa859476ff	OpenID Connect scope for add all basic claims to the token	openid-connect
85c5538e-dcab-4213-ac39-c73b92b87d43	offline_access	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect built-in scope: offline_access	openid-connect
0136e6e0-6bb7-4294-aa97-dcdfc6236c8e	role_list	00164430-588c-4b7e-a550-cedd315756a4	SAML role list	saml
7ac1c79c-3432-42e2-9135-97e14b21f6a1	profile	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect built-in scope: profile	openid-connect
be05d157-5141-4a9a-88a4-039c7146f4d9	email	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect built-in scope: email	openid-connect
f81b3188-6f69-46e1-af62-e368b29dd280	address	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect built-in scope: address	openid-connect
0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	phone	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect built-in scope: phone	openid-connect
46158d19-b10d-46f5-ad2f-8412cd724345	roles	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect scope for add user roles to the access token	openid-connect
b7fa39a6-aac0-4027-acca-4573889cf7c5	web-origins	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	microprofile-jwt	00164430-588c-4b7e-a550-cedd315756a4	Microprofile - JWT built-in scope	openid-connect
7894e9db-2712-4e69-b766-64f4039693b0	acr	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
5a99b4fc-fab6-41c6-ad86-425543435650	basic	00164430-588c-4b7e-a550-cedd315756a4	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
3933f10c-2bee-47ef-8fc2-19c3939753ab	true	display.on.consent.screen
3933f10c-2bee-47ef-8fc2-19c3939753ab	${offlineAccessScopeConsentText}	consent.screen.text
10651b1e-f454-4a13-8519-8c102b3d94db	true	display.on.consent.screen
10651b1e-f454-4a13-8519-8c102b3d94db	${samlRoleListScopeConsentText}	consent.screen.text
c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	true	display.on.consent.screen
c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	${profileScopeConsentText}	consent.screen.text
c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	true	include.in.token.scope
f13d8b38-140f-4d5f-88fb-a07b008ea6c5	true	display.on.consent.screen
f13d8b38-140f-4d5f-88fb-a07b008ea6c5	${emailScopeConsentText}	consent.screen.text
f13d8b38-140f-4d5f-88fb-a07b008ea6c5	true	include.in.token.scope
070f9656-1da4-4dba-bb7f-479f1d3cbec5	true	display.on.consent.screen
070f9656-1da4-4dba-bb7f-479f1d3cbec5	${addressScopeConsentText}	consent.screen.text
070f9656-1da4-4dba-bb7f-479f1d3cbec5	true	include.in.token.scope
d92fbce2-8e26-439e-9cc3-bdc7d5886160	true	display.on.consent.screen
d92fbce2-8e26-439e-9cc3-bdc7d5886160	${phoneScopeConsentText}	consent.screen.text
d92fbce2-8e26-439e-9cc3-bdc7d5886160	true	include.in.token.scope
1268d73b-8909-4d13-ba86-b37057d7f220	true	display.on.consent.screen
1268d73b-8909-4d13-ba86-b37057d7f220	${rolesScopeConsentText}	consent.screen.text
1268d73b-8909-4d13-ba86-b37057d7f220	false	include.in.token.scope
68d802c9-9b18-45dd-87d2-873e1bf4915f	false	display.on.consent.screen
68d802c9-9b18-45dd-87d2-873e1bf4915f		consent.screen.text
68d802c9-9b18-45dd-87d2-873e1bf4915f	false	include.in.token.scope
410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	false	display.on.consent.screen
410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	true	include.in.token.scope
a4da603e-292f-48e3-a837-0f766babe061	false	display.on.consent.screen
a4da603e-292f-48e3-a837-0f766babe061	false	include.in.token.scope
53a294d3-c294-4e23-be32-ffc0919802b9	false	display.on.consent.screen
53a294d3-c294-4e23-be32-ffc0919802b9	false	include.in.token.scope
85c5538e-dcab-4213-ac39-c73b92b87d43	true	display.on.consent.screen
85c5538e-dcab-4213-ac39-c73b92b87d43	${offlineAccessScopeConsentText}	consent.screen.text
0136e6e0-6bb7-4294-aa97-dcdfc6236c8e	true	display.on.consent.screen
0136e6e0-6bb7-4294-aa97-dcdfc6236c8e	${samlRoleListScopeConsentText}	consent.screen.text
7ac1c79c-3432-42e2-9135-97e14b21f6a1	true	display.on.consent.screen
7ac1c79c-3432-42e2-9135-97e14b21f6a1	${profileScopeConsentText}	consent.screen.text
7ac1c79c-3432-42e2-9135-97e14b21f6a1	true	include.in.token.scope
be05d157-5141-4a9a-88a4-039c7146f4d9	true	display.on.consent.screen
be05d157-5141-4a9a-88a4-039c7146f4d9	${emailScopeConsentText}	consent.screen.text
be05d157-5141-4a9a-88a4-039c7146f4d9	true	include.in.token.scope
f81b3188-6f69-46e1-af62-e368b29dd280	true	display.on.consent.screen
f81b3188-6f69-46e1-af62-e368b29dd280	${addressScopeConsentText}	consent.screen.text
f81b3188-6f69-46e1-af62-e368b29dd280	true	include.in.token.scope
0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	true	display.on.consent.screen
0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	${phoneScopeConsentText}	consent.screen.text
0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	true	include.in.token.scope
46158d19-b10d-46f5-ad2f-8412cd724345	true	display.on.consent.screen
46158d19-b10d-46f5-ad2f-8412cd724345	${rolesScopeConsentText}	consent.screen.text
46158d19-b10d-46f5-ad2f-8412cd724345	false	include.in.token.scope
b7fa39a6-aac0-4027-acca-4573889cf7c5	false	display.on.consent.screen
b7fa39a6-aac0-4027-acca-4573889cf7c5		consent.screen.text
b7fa39a6-aac0-4027-acca-4573889cf7c5	false	include.in.token.scope
8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	false	display.on.consent.screen
8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	true	include.in.token.scope
7894e9db-2712-4e69-b766-64f4039693b0	false	display.on.consent.screen
7894e9db-2712-4e69-b766-64f4039693b0	false	include.in.token.scope
5a99b4fc-fab6-41c6-ad86-425543435650	false	display.on.consent.screen
5a99b4fc-fab6-41c6-ad86-425543435650	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
c1e8118b-364d-422d-93f6-03d6e6ef9feb	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	1268d73b-8909-4d13-ba86-b37057d7f220	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	53a294d3-c294-4e23-be32-ffc0919802b9	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	a4da603e-292f-48e3-a837-0f766babe061	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
c1e8118b-364d-422d-93f6-03d6e6ef9feb	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
c1e8118b-364d-422d-93f6-03d6e6ef9feb	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
c1e8118b-364d-422d-93f6-03d6e6ef9feb	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
c1e8118b-364d-422d-93f6-03d6e6ef9feb	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
d4b85b39-6674-433d-844b-6a8d39d8ecce	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	1268d73b-8909-4d13-ba86-b37057d7f220	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	53a294d3-c294-4e23-be32-ffc0919802b9	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	a4da603e-292f-48e3-a837-0f766babe061	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
d4b85b39-6674-433d-844b-6a8d39d8ecce	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
d4b85b39-6674-433d-844b-6a8d39d8ecce	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
d4b85b39-6674-433d-844b-6a8d39d8ecce	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
d4b85b39-6674-433d-844b-6a8d39d8ecce	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
18d9b379-5d67-47f0-9a46-2909fbd01344	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
18d9b379-5d67-47f0-9a46-2909fbd01344	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
18d9b379-5d67-47f0-9a46-2909fbd01344	1268d73b-8909-4d13-ba86-b37057d7f220	t
18d9b379-5d67-47f0-9a46-2909fbd01344	53a294d3-c294-4e23-be32-ffc0919802b9	t
18d9b379-5d67-47f0-9a46-2909fbd01344	a4da603e-292f-48e3-a837-0f766babe061	t
18d9b379-5d67-47f0-9a46-2909fbd01344	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
18d9b379-5d67-47f0-9a46-2909fbd01344	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
18d9b379-5d67-47f0-9a46-2909fbd01344	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
18d9b379-5d67-47f0-9a46-2909fbd01344	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
18d9b379-5d67-47f0-9a46-2909fbd01344	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
eb2f3da9-5568-446b-a1eb-0a05c8987d19	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	1268d73b-8909-4d13-ba86-b37057d7f220	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	53a294d3-c294-4e23-be32-ffc0919802b9	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	a4da603e-292f-48e3-a837-0f766babe061	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
eb2f3da9-5568-446b-a1eb-0a05c8987d19	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
eb2f3da9-5568-446b-a1eb-0a05c8987d19	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
eb2f3da9-5568-446b-a1eb-0a05c8987d19	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
eb2f3da9-5568-446b-a1eb-0a05c8987d19	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
6d49f9d7-5c39-403e-8651-b349982997c6	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
6d49f9d7-5c39-403e-8651-b349982997c6	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
6d49f9d7-5c39-403e-8651-b349982997c6	1268d73b-8909-4d13-ba86-b37057d7f220	t
6d49f9d7-5c39-403e-8651-b349982997c6	53a294d3-c294-4e23-be32-ffc0919802b9	t
6d49f9d7-5c39-403e-8651-b349982997c6	a4da603e-292f-48e3-a837-0f766babe061	t
6d49f9d7-5c39-403e-8651-b349982997c6	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
6d49f9d7-5c39-403e-8651-b349982997c6	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
6d49f9d7-5c39-403e-8651-b349982997c6	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
6d49f9d7-5c39-403e-8651-b349982997c6	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
6d49f9d7-5c39-403e-8651-b349982997c6	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
83d065c1-c30e-4b10-8e1d-399a201d4805	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
83d065c1-c30e-4b10-8e1d-399a201d4805	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
83d065c1-c30e-4b10-8e1d-399a201d4805	1268d73b-8909-4d13-ba86-b37057d7f220	t
83d065c1-c30e-4b10-8e1d-399a201d4805	53a294d3-c294-4e23-be32-ffc0919802b9	t
83d065c1-c30e-4b10-8e1d-399a201d4805	a4da603e-292f-48e3-a837-0f766babe061	t
83d065c1-c30e-4b10-8e1d-399a201d4805	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
83d065c1-c30e-4b10-8e1d-399a201d4805	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
83d065c1-c30e-4b10-8e1d-399a201d4805	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
83d065c1-c30e-4b10-8e1d-399a201d4805	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
83d065c1-c30e-4b10-8e1d-399a201d4805	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
d2900d29-9eee-4985-b398-9b1d9908b742	7894e9db-2712-4e69-b766-64f4039693b0	t
d2900d29-9eee-4985-b398-9b1d9908b742	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
d2900d29-9eee-4985-b398-9b1d9908b742	5a99b4fc-fab6-41c6-ad86-425543435650	t
d2900d29-9eee-4985-b398-9b1d9908b742	be05d157-5141-4a9a-88a4-039c7146f4d9	t
d2900d29-9eee-4985-b398-9b1d9908b742	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
d2900d29-9eee-4985-b398-9b1d9908b742	46158d19-b10d-46f5-ad2f-8412cd724345	t
d2900d29-9eee-4985-b398-9b1d9908b742	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
d2900d29-9eee-4985-b398-9b1d9908b742	f81b3188-6f69-46e1-af62-e368b29dd280	f
d2900d29-9eee-4985-b398-9b1d9908b742	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
d2900d29-9eee-4985-b398-9b1d9908b742	85c5538e-dcab-4213-ac39-c73b92b87d43	f
6eed25a6-533d-42d1-a2b7-385062550518	7894e9db-2712-4e69-b766-64f4039693b0	t
6eed25a6-533d-42d1-a2b7-385062550518	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
6eed25a6-533d-42d1-a2b7-385062550518	5a99b4fc-fab6-41c6-ad86-425543435650	t
6eed25a6-533d-42d1-a2b7-385062550518	be05d157-5141-4a9a-88a4-039c7146f4d9	t
6eed25a6-533d-42d1-a2b7-385062550518	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
6eed25a6-533d-42d1-a2b7-385062550518	46158d19-b10d-46f5-ad2f-8412cd724345	t
6eed25a6-533d-42d1-a2b7-385062550518	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
6eed25a6-533d-42d1-a2b7-385062550518	f81b3188-6f69-46e1-af62-e368b29dd280	f
6eed25a6-533d-42d1-a2b7-385062550518	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
6eed25a6-533d-42d1-a2b7-385062550518	85c5538e-dcab-4213-ac39-c73b92b87d43	f
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	7894e9db-2712-4e69-b766-64f4039693b0	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	5a99b4fc-fab6-41c6-ad86-425543435650	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	be05d157-5141-4a9a-88a4-039c7146f4d9	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	46158d19-b10d-46f5-ad2f-8412cd724345	t
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	f81b3188-6f69-46e1-af62-e368b29dd280	f
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
6c7fa4e8-637f-4c2b-96f9-bfa34a83c877	85c5538e-dcab-4213-ac39-c73b92b87d43	f
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	7894e9db-2712-4e69-b766-64f4039693b0	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	5a99b4fc-fab6-41c6-ad86-425543435650	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	be05d157-5141-4a9a-88a4-039c7146f4d9	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	46158d19-b10d-46f5-ad2f-8412cd724345	t
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	f81b3188-6f69-46e1-af62-e368b29dd280	f
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	85c5538e-dcab-4213-ac39-c73b92b87d43	f
75041075-d112-404a-ad59-16fae2dbb663	7894e9db-2712-4e69-b766-64f4039693b0	t
75041075-d112-404a-ad59-16fae2dbb663	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
75041075-d112-404a-ad59-16fae2dbb663	5a99b4fc-fab6-41c6-ad86-425543435650	t
75041075-d112-404a-ad59-16fae2dbb663	be05d157-5141-4a9a-88a4-039c7146f4d9	t
75041075-d112-404a-ad59-16fae2dbb663	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
75041075-d112-404a-ad59-16fae2dbb663	46158d19-b10d-46f5-ad2f-8412cd724345	t
75041075-d112-404a-ad59-16fae2dbb663	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
75041075-d112-404a-ad59-16fae2dbb663	f81b3188-6f69-46e1-af62-e368b29dd280	f
75041075-d112-404a-ad59-16fae2dbb663	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
75041075-d112-404a-ad59-16fae2dbb663	85c5538e-dcab-4213-ac39-c73b92b87d43	f
33a02fbc-ce94-41de-bea8-afedd6f6b780	7894e9db-2712-4e69-b766-64f4039693b0	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	5a99b4fc-fab6-41c6-ad86-425543435650	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	be05d157-5141-4a9a-88a4-039c7146f4d9	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	46158d19-b10d-46f5-ad2f-8412cd724345	t
33a02fbc-ce94-41de-bea8-afedd6f6b780	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
33a02fbc-ce94-41de-bea8-afedd6f6b780	f81b3188-6f69-46e1-af62-e368b29dd280	f
33a02fbc-ce94-41de-bea8-afedd6f6b780	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
33a02fbc-ce94-41de-bea8-afedd6f6b780	85c5538e-dcab-4213-ac39-c73b92b87d43	f
305eeea6-c469-4d38-a79b-df23ef9f25da	7894e9db-2712-4e69-b766-64f4039693b0	t
305eeea6-c469-4d38-a79b-df23ef9f25da	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
305eeea6-c469-4d38-a79b-df23ef9f25da	5a99b4fc-fab6-41c6-ad86-425543435650	t
305eeea6-c469-4d38-a79b-df23ef9f25da	be05d157-5141-4a9a-88a4-039c7146f4d9	t
305eeea6-c469-4d38-a79b-df23ef9f25da	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
305eeea6-c469-4d38-a79b-df23ef9f25da	46158d19-b10d-46f5-ad2f-8412cd724345	t
305eeea6-c469-4d38-a79b-df23ef9f25da	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
305eeea6-c469-4d38-a79b-df23ef9f25da	f81b3188-6f69-46e1-af62-e368b29dd280	f
305eeea6-c469-4d38-a79b-df23ef9f25da	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
305eeea6-c469-4d38-a79b-df23ef9f25da	85c5538e-dcab-4213-ac39-c73b92b87d43	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
3933f10c-2bee-47ef-8fc2-19c3939753ab	f131ac38-dd84-49e4-a1b4-acbd717383ed
85c5538e-dcab-4213-ac39-c73b92b87d43	5a5d71e3-f2c0-412a-9955-d3d0e76af2fb
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
87731ca1-1584-495b-b29b-f080613b623b	Trusted Hosts	2eca1426-cce8-48c4-a944-90aa859476ff	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
16ae896f-d001-46a2-bb14-dda014d66b66	Consent Required	2eca1426-cce8-48c4-a944-90aa859476ff	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
a0441327-004c-4d23-bcce-e8cdbbe8b3aa	Full Scope Disabled	2eca1426-cce8-48c4-a944-90aa859476ff	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
ff8f78f1-867a-42f2-a0f4-49d7de0cbd9e	Max Clients Limit	2eca1426-cce8-48c4-a944-90aa859476ff	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
da717329-b48d-4c01-8b85-5321558e4ccd	Allowed Protocol Mapper Types	2eca1426-cce8-48c4-a944-90aa859476ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
7105ec37-ec00-48f7-81e5-87e8d2b8d243	Allowed Client Scopes	2eca1426-cce8-48c4-a944-90aa859476ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	anonymous
0612fc29-d3c6-4fd4-b37b-368619ed4bd8	Allowed Protocol Mapper Types	2eca1426-cce8-48c4-a944-90aa859476ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	authenticated
a204e1b2-e11b-48d5-aa78-20076a1a1245	Allowed Client Scopes	2eca1426-cce8-48c4-a944-90aa859476ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	authenticated
dd4b6687-9d36-4085-bb95-08c01e14403f	rsa-generated	2eca1426-cce8-48c4-a944-90aa859476ff	rsa-generated	org.keycloak.keys.KeyProvider	2eca1426-cce8-48c4-a944-90aa859476ff	\N
c6643e20-8681-40d8-a028-bb862bb47c61	rsa-enc-generated	2eca1426-cce8-48c4-a944-90aa859476ff	rsa-enc-generated	org.keycloak.keys.KeyProvider	2eca1426-cce8-48c4-a944-90aa859476ff	\N
818c47cf-0f2c-4cd1-a1b9-45ea13b604a9	hmac-generated-hs512	2eca1426-cce8-48c4-a944-90aa859476ff	hmac-generated	org.keycloak.keys.KeyProvider	2eca1426-cce8-48c4-a944-90aa859476ff	\N
0749c957-946b-4c2e-8ebe-76140c50b4fc	aes-generated	2eca1426-cce8-48c4-a944-90aa859476ff	aes-generated	org.keycloak.keys.KeyProvider	2eca1426-cce8-48c4-a944-90aa859476ff	\N
8b54bd13-279a-4b41-b220-a73f2b37d947	\N	2eca1426-cce8-48c4-a944-90aa859476ff	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	2eca1426-cce8-48c4-a944-90aa859476ff	\N
86154da4-c96b-4397-b3f7-d696fddf06d5	rsa-generated	00164430-588c-4b7e-a550-cedd315756a4	rsa-generated	org.keycloak.keys.KeyProvider	00164430-588c-4b7e-a550-cedd315756a4	\N
b8476e9c-3217-46d0-8553-dd7dedb544d5	rsa-enc-generated	00164430-588c-4b7e-a550-cedd315756a4	rsa-enc-generated	org.keycloak.keys.KeyProvider	00164430-588c-4b7e-a550-cedd315756a4	\N
ee1f2cc1-4412-4d0a-b5a6-f668767d497f	hmac-generated-hs512	00164430-588c-4b7e-a550-cedd315756a4	hmac-generated	org.keycloak.keys.KeyProvider	00164430-588c-4b7e-a550-cedd315756a4	\N
bc370621-519c-4d65-baa3-5ee5b0e5ed7d	aes-generated	00164430-588c-4b7e-a550-cedd315756a4	aes-generated	org.keycloak.keys.KeyProvider	00164430-588c-4b7e-a550-cedd315756a4	\N
3fb58177-8857-4f50-83a5-713e461598f6	Trusted Hosts	00164430-588c-4b7e-a550-cedd315756a4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
ab4683d7-c92b-422a-aff3-da4b6bc92d57	Consent Required	00164430-588c-4b7e-a550-cedd315756a4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
a2441a31-0f3b-481d-bf44-647daa64de89	Full Scope Disabled	00164430-588c-4b7e-a550-cedd315756a4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
7149067f-d78d-4828-9239-df1ca2ee7348	Max Clients Limit	00164430-588c-4b7e-a550-cedd315756a4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
864a99f5-81c9-4bad-887b-0d7c83187d83	Allowed Protocol Mapper Types	00164430-588c-4b7e-a550-cedd315756a4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
21da5447-c016-4884-9f68-594ca6809571	Allowed Client Scopes	00164430-588c-4b7e-a550-cedd315756a4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	anonymous
fd844c0b-2b3f-47b4-9e68-b6a123d14635	Allowed Protocol Mapper Types	00164430-588c-4b7e-a550-cedd315756a4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	authenticated
b5a13346-ccc3-4d64-9288-a26947e3c152	Allowed Client Scopes	00164430-588c-4b7e-a550-cedd315756a4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	00164430-588c-4b7e-a550-cedd315756a4	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
ff08098c-2737-4f5c-9d73-24967888c2e5	ff8f78f1-867a-42f2-a0f4-49d7de0cbd9e	max-clients	200
07805eee-7404-49d8-9aa1-82bd7d08f278	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8eca4526-631b-4a3c-bd44-273e1796ea5c	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	saml-role-list-mapper
6368467b-bf09-4454-938b-b1b649e8ab81	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	saml-user-attribute-mapper
3b121b09-be69-4ec8-ba17-5b6f6b9b9ada	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	saml-user-property-mapper
4d1de6a7-fd72-4e66-9c2d-8e79dd8da0fb	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2a8eeffc-62e0-4f82-bb95-0a8a4aab8b3e	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	oidc-address-mapper
197119c7-b680-40a8-a9a4-1595d3a7b124	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
634807f8-8bde-4fd4-bf93-d1f379048c0e	0612fc29-d3c6-4fd4-b37b-368619ed4bd8	allowed-protocol-mapper-types	oidc-full-name-mapper
ad70ea85-e3bd-4e09-9a76-013dff611623	7105ec37-ec00-48f7-81e5-87e8d2b8d243	allow-default-scopes	true
3b81668a-027d-4226-b86b-0e21d27d1673	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	saml-role-list-mapper
0d8db089-3dde-4509-8e19-fc182e05d0d9	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	saml-user-attribute-mapper
013a1deb-173f-4c4b-a137-42739175955d	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f49b6ef9-2d4f-4422-8435-6f69d36240e7	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	saml-user-property-mapper
a4764db5-759e-4b88-85f4-652093f29f41	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	oidc-address-mapper
e2d4a0a5-3ea2-4daf-8a26-c524d1b831c3	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
53c6d4d0-9ffd-42d7-baf1-840782436223	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b9295071-b3f0-4cab-9237-8f7e9c7c9d4a	da717329-b48d-4c01-8b85-5321558e4ccd	allowed-protocol-mapper-types	oidc-full-name-mapper
eacea921-6474-453a-910b-bb852cf2f9ad	a204e1b2-e11b-48d5-aa78-20076a1a1245	allow-default-scopes	true
54b76e71-4ea7-4933-b185-daa69ede2c36	87731ca1-1584-495b-b29b-f080613b623b	host-sending-registration-request-must-match	true
70d0019d-2e19-4027-8281-d62d9652c4b9	87731ca1-1584-495b-b29b-f080613b623b	client-uris-must-match	true
51d21fab-f644-4e36-953a-a2c29a0cea0b	0749c957-946b-4c2e-8ebe-76140c50b4fc	secret	Eobe0OYP9JNbz8tTU2VkJg
ec3fce14-b9f3-48a0-b5e5-f10d369e0a07	0749c957-946b-4c2e-8ebe-76140c50b4fc	priority	100
8576b7be-d058-4941-be47-bf75bd1ce2da	0749c957-946b-4c2e-8ebe-76140c50b4fc	kid	20e9f155-691a-48b8-877f-d14ca04e4f90
82074317-7a43-4efe-8c57-d39cc83e3a37	dd4b6687-9d36-4085-bb95-08c01e14403f	keyUse	SIG
0b7647ec-6976-4ac0-8da4-0aab10c12223	dd4b6687-9d36-4085-bb95-08c01e14403f	privateKey	MIIEowIBAAKCAQEAq7o8s7pE0Ts+lhhjITYAE362xaj5Ht57EE19JxFoAEfjvI8Fp0JRQ/kHFifZ+ebBEMzOs0HmQscs28lwG8PD4vUzj9b36sOTDfpt2Evvxp5609z1/zFVkE9uCVn9j30EdDuMVwkNxFqNIiOF09IB8h4iliAXo2VYxmz5k06WJnN+e+itbjqwOnBC2PzttzvvmlbuDAUpioDWmClgSdx8SFslm4QQP6DojSRJoFqVl2EEG6WYcZgBvJRSrg0t/r5ZjBAeq2kXKSFgjv768tUQnQgO4MaZZ83Ps03tJ5uC2MlCEZ5myz4VrF872RxhToA9weKouPXDSiXRLA3XTTab+QIDAQABAoIBABRRowbPhH6+vC0piconT+s+mBzrXT2hLK29Q3CM01HML8ay5AP6OXAZ3jQphzW1z1R/7Tmh059FXpoLW73XRB1drqoHcRpYpXTXE6nu8zocrJMWnw9AvLtoYJBP8uvoSo9/r79pGXVJEw+t5RLu82680NITTkS1tEM3J/EdcG/wUxGxJG/wWM0TrOR99Lj83C5FsZFRu9H8UaMQVwpikOASF1yDPngyAUEexwigcCgE4QKWgIGgcGoApuLaQLr6YlDPKzKJwTB/DFRPRMqNpx6abtrrXzMlP6HJMPy0KTyKPnB6gaPn/kIuQgZHBT9HEdCblcE82fsz8OgmtF+lGZECgYEA0vfNx8aRVMKaQkV6sIxJRIadwkwrD6A/YMZ9vKKFYSctfDX47pB0rxbxe1ZUX0RxiJjZ8SWCa89IxadSIBlKyw/R4yhCtp5Eh1GDAN+EUcHBcUlOooBL3QtkWF9BDZxdU2a6zAIC0taeMOS6/jXAbejxoFS7Ga9K/g3sf1C1DMkCgYEA0GIqCa63kvmLCZ7bqWA6q2cesF5sRc7Ea9UHxdC6QgcLiT8HlMWRt97w/gFYgG7F5p3QCX3x56M3+B9RLlUy34ot8sKMzob751ZqIkAqkE6guTh/V9xSYwAIF9/7aejrHjIYEl1Bi3NxbpJxq5WyA2aNefsRqi09X/31e/nmHbECgYEAwxnodJhuTrSpdCBNFnimSXk07DsEl67a7eSi45BpSS+yIOzJCdcOEd5l9GoiHPhvBqRU6W6G7q0D38adbJH3WVOIB0t0Zu528a2wOV58QB+vhdUFo8KCZini4tc0kiHJLRgUKBa0Bcf1A8KELBQJoZuL2XqCjX5PHCREUnmQ9gECgYAgKXZ5hhjZO2ClPHqEutBzUfgfmoM1hwMz7W5ErsGAnVu/dBX0dUXXTjZ9zbFeKTqsLGFGhcTHTp690f+Smh2++LG8zSA0ZAsPGnxJCwRGv4v46mplIiEpHIEjRjOklglr4KlsdC5AmrHAMiQPKoyOD874K7L/Q/o8DZNM7jYBEQKBgEZAd8vYu6O4srgAxZp4Zw4VlrKRwm6ZiZIVZ99QqKHDNBkcHUi9h0XTvvovgNK5MFMtoaSj4UNCUWhejxiFlplqh4r5tj8WZ8kd/BOcUf/mhT36GygD8JVYRF6QhTXKzDmAaABvRHmesnH4NPP8O8G3P3OAWV/41xWlvY5sIj42
abc685d1-c830-4a82-a961-6d2af05a6274	dd4b6687-9d36-4085-bb95-08c01e14403f	priority	100
72665b83-8218-4091-a7a2-e6ae533fdc8d	dd4b6687-9d36-4085-bb95-08c01e14403f	certificate	MIICmzCCAYMCBgGQfZ3AUjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzA0MTE1ODI4WhcNMzQwNzA0MTIwMDA4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCrujyzukTROz6WGGMhNgATfrbFqPke3nsQTX0nEWgAR+O8jwWnQlFD+QcWJ9n55sEQzM6zQeZCxyzbyXAbw8Pi9TOP1vfqw5MN+m3YS+/GnnrT3PX/MVWQT24JWf2PfQR0O4xXCQ3EWo0iI4XT0gHyHiKWIBejZVjGbPmTTpYmc3576K1uOrA6cELY/O23O++aVu4MBSmKgNaYKWBJ3HxIWyWbhBA/oOiNJEmgWpWXYQQbpZhxmAG8lFKuDS3+vlmMEB6raRcpIWCO/vry1RCdCA7gxplnzc+zTe0nm4LYyUIRnmbLPhWsXzvZHGFOgD3B4qi49cNKJdEsDddNNpv5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJT54BWzB0iTZ3+FXHEdke9hSnelY2VvFUOsDBqrWZ4mxTSU3Y7r3UpC+0r1jL5PRbAfMmQrXh5a5QvVDwP+adZkOqKnilRAaf5AlpjI2m5vrHi0VbAscjeY7uEDJtCKJISletZL+RFdMPTY9mkF9qI/YnyL3qRvs+TVPjdgGw42wBhaB5tLbx3kHcuuxXiTG65oH9L1OfErZaPAXxCnoQdfYuYbomffz0XwP/8ans++IizQ7Kl3Lx6yiqrdgsLkONcEwbK4F3M+EaAwXzINOh3ma90bgpo2kqId2PR/qYDGnlkuCDlA2sRMdDr/o/jcuZTvob118JmtB4qeCJokd9Y=
68efb5ae-2949-49a1-9104-8faa4052aa9e	c6643e20-8681-40d8-a028-bb862bb47c61	algorithm	RSA-OAEP
4805bb49-ca3c-4a39-b277-6347a82c8893	c6643e20-8681-40d8-a028-bb862bb47c61	keyUse	ENC
3b7273b5-6d03-49e3-a455-ce92fb627f41	c6643e20-8681-40d8-a028-bb862bb47c61	certificate	MIICmzCCAYMCBgGQfZ3AuDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzA0MTE1ODI4WhcNMzQwNzA0MTIwMDA4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZbgjid12S7OVnAvk2eQDl9nnOn1QekG9m0FxE9vHN/tAoRo/S2G1s8qkqGpU8RAOQBx9C2ACobQROLnjaoUorRrxKfMEbOAJPuQVvNh1AMI0eL0csV3GdyyLW23Z44Q8Z1tbTtmMXWJPKub0pCdnjL2BPQaYuJ2re6sSjM1z4/ZuCz+bXmyWXtuaLI76loEtcOCRypEmImJcGIx6v4H8eQHQqtLrlSSvMWUXlPIU1huZtefIB1U6fJ6yoyv19zliA/MRGg6/aeGAF0Vni+aCz7gMVa8x9WA2I2ZooSL82RRdY3ZrYW7P7qP0t9z8EjEwKamU3wVhU7oGVcfzW5QdNAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACPvDArKG67Wy0x+znbC39lfJ6S8dEgxNPL3QExkNVKK65CC+xLKUZOn+9+jLkRgAKVIgl6kA36cK1IvhHydfWbAK6VO6hDWbr5ADakkpG+bD0KOVf0+lNsled6IF821UvOHrI6iLySbh08Vwcq7E8VIGtY77JJba82xRKUoeaiJ48XouXIDZihz9H/ridbM9Evkbp4/z8BWmEUmloN5EKNeMPHrIWeBHhA0FB4oVOvCYmuBu/FL5zmRPHcO+/5R7dloAOhoCZovbDwm2rm0c9YZ58LlgSyOx0aTFjuFmDVSQAPwJv0fxA4FdWGNon+5+DB2g+yNhu8j5+l1BXh6VL8=
84aeac3b-2330-4a82-9f31-ad60793dd334	c6643e20-8681-40d8-a028-bb862bb47c61	privateKey	MIIEowIBAAKCAQEAmW4I4nddkuzlZwL5NnkA5fZ5zp9UHpBvZtBcRPbxzf7QKEaP0thtbPKpKhqVPEQDkAcfQtgAqG0ETi542qFKK0a8SnzBGzgCT7kFbzYdQDCNHi9HLFdxncsi1tt2eOEPGdbW07ZjF1iTyrm9KQnZ4y9gT0GmLidq3urEozNc+P2bgs/m15sll7bmiyO+paBLXDgkcqRJiJiXBiMer+B/HkB0KrS65UkrzFlF5TyFNYbmbXnyAdVOnyesqMr9fc5YgPzERoOv2nhgBdFZ4vmgs+4DFWvMfVgNiNmaKEi/NkUXWN2a2Fuz+6j9Lfc/BIxMCmplN8FYVO6BlXH81uUHTQIDAQABAoIBAADll4LetermBxjrzRygJvJGgfju+KfSv3qfSlbIhxUllukRW9sHPavWxvMyeL+uLxjQWIKvGWE3/T/evivwUusUrK+Wce4wjN+TQjX09UVQM1b4lEbXqQKbiB6E5bj4VHqvGo4za/oG4BrzLH5OVYTM3K2B7FCAlaZBbY5S/nQMdyJsSkWGIgN+E2ztfUKLPeIO1rqjlawj+Dl+ZoZQ0w8u4AnD0Pwy1UX399auVAPShy8L2ympz2/kTpTD2hLoG+KGa0lhSlMg5bkQeTAGraroJ1PfXLAoz1oRuSwzFRT7c6Gu1TPaMJXqRiU43iHJajyJ3gAjhoaPoZMq5p9u6HECgYEA0H/idWSztrksbJzvAfTW1AAj21LeZK9Puwp9EtB2SPFx7ABYKC0mheqpYXNIt94AItzzGmfAhTYbMPHNkuGDpXSFJGeVlnYM1MoJ9TfdnO+p5OSt5KJ3OLddzq1PKEc+fVZy2D5qa33OJ+Eu0Y9fJHzwvCufCxpzscI3ZxwzK3ECgYEAvGJfTrZLl3AphZEm20wLngesn+bRGhqDJNkYB0XtRkOSS9Eiby4X+X27YbNGXl2RVzNjkCP74fH9oey36dpfqozZUQntBAGlue0SPL12/dzG8MlsnZueDaVFugu0vNB8aweersOO3g511FsWCx63adpeEYPYy1xYTjSWqqrqE50CgYEAzCQab0R87TAa/fEd1rWJzaKhePGHS9+WWhTn5w7ycXLtTtv7dMLYUBA1bXO5xET5ryjUYYsqJYOXVfG6jNB+2/XdEorVHK9S2tlCrLTZJ/pERxdb51rnDkIC+AQaV96BoaiN44ohGkPgII3LEGWnCwvFjQfMvctVcbsuEae7thECgYALOBSS/HpN/4kJglZ9Eu9SLwTR1Q447sFGrYMn07tIxvdsen0BgA4/doR1UhbrwcjJF69jQzFaCG5heVaOn8m4v4ClueCar3puMzc11NbEUaSrbGOCk2T7TQ91AAN4hzYRrbd+kvjsMpJD3lTWvrKPpEib5G1B1zMPHUSnz1v3ZQKBgAFMX099vZooStEIdw6YLjxRUN0ElrQ2AKk/jQNtrz5rF26+GE9FIFlAyC9WPQU8o16W0zS7E1Ef6TudNIjon4OfdYjzcCycIPBkIwr+Vn0jlWqYcl9kcOK4VjQYAKktN8HJpg/BKYZO8N8oNmVdvHrp3/8fzst408R7lkKixwB8
4ed776e2-4172-4443-809e-5d792b3b023a	c6643e20-8681-40d8-a028-bb862bb47c61	priority	100
35c6d083-f8a8-43c7-9456-1e0dace90e18	818c47cf-0f2c-4cd1-a1b9-45ea13b604a9	kid	108c6516-3660-45d5-bd7a-f140eafac5d1
15ea8531-6a8e-4e9b-bde3-5ea86dcf5923	818c47cf-0f2c-4cd1-a1b9-45ea13b604a9	secret	Lz9n_v-k5yYXazVdWzy87GvcxTXOkqk4sAcc4U5k9Xo_Dmkfbe6IvTezE2LFGbvcdi939Rgzc5rKXCKIVduvmyZ5-ZvzajYd2ASPwNBe3_LFevSNEaADgKWldGI2zpXf6V-75s_VUx-VxIjlyPOdcMmCeq1X9PXldt1wTC2QIKQ
7b7a570b-624c-49dc-9661-0ecce22c1f6c	818c47cf-0f2c-4cd1-a1b9-45ea13b604a9	priority	100
de1d6aca-7eaa-4475-aca3-fbeb112c845b	818c47cf-0f2c-4cd1-a1b9-45ea13b604a9	algorithm	HS512
1d1fcfea-ac09-432a-b5c2-ec9d5680595b	8b54bd13-279a-4b41-b220-a73f2b37d947	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
a70ba6b6-73ed-4bf9-8ced-e568dac57b53	86154da4-c96b-4397-b3f7-d696fddf06d5	keyUse	SIG
ad3744c1-ba8d-4318-973e-094e9d6e7208	86154da4-c96b-4397-b3f7-d696fddf06d5	privateKey	MIIEogIBAAKCAQEAsrQ+U/iGixmwQMVzufCI4l8cCiRvy3OODgL3e97Ssph2RDXG2WC+MtYNEZB1Nv71AgFCZZXvKcqBsYoUXcmKjle0lZcTJmttvOE1oqqzWYhe7ipfWW1VYoCy3r68jnoTnay20KO3CIfn1/zXFwMSI6bMTtFdmD6XPXKIUumDpzCFVyOEM5LPYLzmedQdrt9Re+yzF9fwLaxPv6SbPiSc9C2iVFbuG4BrK1QglOL4NWEZrQ1ItWBrP3Keyy53euptNZc/kMsQz1cFb5w8/S2OxQxeqMvAmYCX8FLRb3zU2zce0VrIQafx1S5HIi+hrDfyV0aAcO0FJ5zIc95tXroDoQIDAQABAoIBACIKqFHeJqESUmswQeCSg7zdoc2DzeELgOzF32eTFX9sgCDzvo6zuV+dO22UX2PL0xff7gpEcsP6/dQ4abNI/HIrnmydlAoOTl/75bf4PQSJ8A19+F5kb669NfWtD2Wztw9i8otRmIERRJa2JTIOxXKRqFs+Uk45ZB2SNwpWTdw31j13sKW/MAjO2CBWyGGwHUbzt2rp5P9iWH87wdgzsHbasqbq/6O6zgpoijbcKT/g5aVh/KHrsC1Jmbw/JnVT6/ku/7OstOpS0B3hinQ1uh7xviXYmWBWDpL5/rAbYCdKKcOeQNtVu43Jm55MAEA2vAQEWyfWLJHnCy3RdUqtFy0CgYEA1kVCItP/98gWW4MlvzBDkzwY7s0w6LZIeXmr5uDQ87TB54eeheI94cdd8gQKuy4scWh31VkHXM2af+RxPoruiVHLjzSyy0E4ds2n60ab6nohWegkYoofNqryf6De7m4j8+HFx1HwqL3Pyl4O3j89M/uIrpOplWY4FgqTQJzvga0CgYEA1YHFnPRPmlcfG7XmYaSPRB19hZpD3WCm+G3mwqXQcixcyTKR2t9L+/z0PIhGmotREVBGRvudgg6e/GC0gNODmMZYP57Gy4eIRWb94igA5QAcRD3vK084t/6f47BMMHLhvL9CenpRdf+n6RMlEEG1E08Tniem3wtPNyNe/dD+UEUCgYAh8mETAYFpMUMRhoqharUaC4hrtQiNpet/i15HutB/++BInTzpOznQnnRs1mUY2Kzj3sg1feBjvJNAteGXJg26pcHZU2EMQK4AbH6xEMO891J3WwcAsZ9WWukGfWc0YTDC/78E4B9/rGrSReqXHW/F35D9D5nreIFkRJKlxvdPFQKBgCyaRqkqVLLefm4wiuddFFzbeEx/1KubtGXzt6B0OV6Qq/WQLe42dc43ouI+admBPzdJuNS9XcM8wLPik/LRvQ0eanMn/Umpj6tH/8POLZmpcz5CXgODMksl00simlgIt+XRYtbpVLk85lwHlteVknltLKD+kZrI5wySxBZsIaStAoGAX1s9rjgZsKSTzc7ee5gKj+OK47DHEhrvZB1CsGp8uKOhNCQfN68zz0BWBK2rXp8v9atjq/Il4aUW5Hba13x6m85a1N7G+8FoyTFJhJ8DM/ZH6PmJpchMjaxW7eUv36PJLpy+lqdaeQtIerc8RKOhuuRVjyhF5HZWWeFIcT8eyIE=
745fe074-cfe9-4cdf-b928-52de151bff49	86154da4-c96b-4397-b3f7-d696fddf06d5	certificate	MIICpzCCAY8CBgGQfZ7LfTANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wHhcNMjQwNzA0MTE1OTM3WhcNMzQwNzA0MTIwMTE3WjAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCytD5T+IaLGbBAxXO58IjiXxwKJG/Lc44OAvd73tKymHZENcbZYL4y1g0RkHU2/vUCAUJlle8pyoGxihRdyYqOV7SVlxMma2284TWiqrNZiF7uKl9ZbVVigLLevryOehOdrLbQo7cIh+fX/NcXAxIjpsxO0V2YPpc9cohS6YOnMIVXI4Qzks9gvOZ51B2u31F77LMX1/AtrE+/pJs+JJz0LaJUVu4bgGsrVCCU4vg1YRmtDUi1YGs/cp7LLnd66m01lz+QyxDPVwVvnDz9LY7FDF6oy8CZgJfwUtFvfNTbNx7RWshBp/HVLkciL6GsN/JXRoBw7QUnnMhz3m1eugOhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAESrF6XXrn9iWCidrYpoDqT73AlnLUvxF1tMjYE56nwMka3vEW6UX8rmbDyn7Ve4PGURsm4ypfPqKtD3H/jfsI5tyUaRly2VdXC+ip8VM1X14i2tUV6I1wofGQTxvIptNnxP46bhud8V2ABny8W0ltOOV8WDU4ZkdQzMfveK5j15Ua0BrAtMW0QQlDSxArA2GOGvxOiuent2dbkBBs+d2St3OVGNr4fujNgF4zghe/yj65s9Z0O5xP0mTVcAZUtrl+DkeOz5fpc5mxvliTa/n5d9v5R6ysdZcsa13CstJcjk/NysIiNQw7zILXnQfbO/m1h8Su3cvjETmW5CsdxJ/DA=
246d52c2-f7cd-41eb-bbd1-20309b766492	86154da4-c96b-4397-b3f7-d696fddf06d5	priority	100
36be9e77-4c2d-40b5-90b7-d8155c593a0c	b8476e9c-3217-46d0-8553-dd7dedb544d5	priority	100
2bfdcf25-757d-4425-8d3c-1e3c9e27014c	b8476e9c-3217-46d0-8553-dd7dedb544d5	certificate	MIICpzCCAY8CBgGQfZ7MHzANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wHhcNMjQwNzA0MTE1OTM3WhcNMzQwNzA0MTIwMTE3WjAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC5m0n8yuLCaHmqvSNa1Od3Fn86lejkR6l9QQg5zZNCOOhHZ7FigJqC23yyPq/WieqhksmVaNbZRzhLbtgPhuIEP7e1k/j8Tqv48+CMkaTKSw8cTadlwy0Ft6vYf5wwWRHHdBGzZZONp7RTNn9VYjX7pypPRVCdZkS30QF7eFuY/cso2v7I6mlgsjBmdbiTzK4yy5rCvtIf3Erzf8fGq8Kz32OP0U9iAbYIGB33IyrXiPW4/vUYcEZlnL3abgOjh/tOoJ5pOflbHJimjDWi91VSDU60LQGTkiAkeJFLGYxy9U2Z1dTUI6AgVlAR1vS8kl4EabziA+v21TvDRHsdpQ+tAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALlwDyr9O0DQzq35ls0/K1xPHjjzGy8OJLYqwnW6Pt4hJ8FWCqj6LLvbLv8BYmKgcuhVfp7QpQamg2/Lrn0LURmWvoBj9ilCHDBPrSUiV8MsHjuxBO7NoiY36B2M5UKRYa5xSTc6nT3tQD3PVuJdHg/lzkODI3lQajmjrJi1O3gkKPUqouDSFplNZyYmLsTqqhl/1VDK28VsO0qoQ0rGdHwW6CtghU6cvXepGeUpqLWqPsW0APQ5jn8xU56eaJnqRLcMXckZeCyE5zJ3x+R2pHUUhMYQCpaN97oquCrHuGAZnd7iTxg6cKxpWS0rJZefUwM1AT9UXSAj4LDuMqUUEZs=
3d3d1356-f411-4677-8981-81d0f84a9a87	b8476e9c-3217-46d0-8553-dd7dedb544d5	privateKey	MIIEowIBAAKCAQEAuZtJ/Mriwmh5qr0jWtTndxZ/OpXo5EepfUEIOc2TQjjoR2exYoCagtt8sj6v1onqoZLJlWjW2Uc4S27YD4biBD+3tZP4/E6r+PPgjJGkyksPHE2nZcMtBber2H+cMFkRx3QRs2WTjae0UzZ/VWI1+6cqT0VQnWZEt9EBe3hbmP3LKNr+yOppYLIwZnW4k8yuMsuawr7SH9xK83/HxqvCs99jj9FPYgG2CBgd9yMq14j1uP71GHBGZZy92m4Do4f7TqCeaTn5WxyYpow1ovdVUg1OtC0Bk5IgJHiRSxmMcvVNmdXU1COgIFZQEdb0vJJeBGm84gPr9tU7w0R7HaUPrQIDAQABAoIBABDgXNbef8XbiAyNTBSrPSyn4AOss9Nl7LRV4HCZD6W61OwBMrDZLrNtT6ZJauWf/rSYSzoJoVd6UVUSjBTFV/G49XROMxqF8L8fNbCyYYB/WK1jJjBrkcFuVPLHj6UZxDMVi7J7LvJ3aD8UunlCB9SM+5zfmZfmP6NTHsZiSDnd2d6C+qCtM3kS/eXe9UadoXikTWGQ9EdKZu0VomcukjlHf95pfqG0TTkpafeyuzhwTZdI2xzyLyGJFhLwMKKQ9752cgmfI4u9F7e7eFPo+hM/Y/QNMNlmZyhnTGPUrHnnyvd/Hnnvwq5b0TaWZz9l1YM3HGsRY+0YlU1nCmDtACECgYEA9KWfaMu9SOCQreTMuC7JMg0thbhNpcyeX06aQMOlXNthGFRf94Yc84WgyCEsp2CLhgM1E8IS5wWNXCQCkBMkxvTSZp3zr1KJUnTCAvGjEgZWQJbQHKOP5CFkymPTXoUONjiNKZLR/QCqb7SXIG08mzwVnBnLQ4ieA+fWWpxHrDUCgYEAwjhGD+zF2BnHmGEPPZaX/qX+DepAHoY/2CmIoF3CEtpaPm8QuUjB9xKzAGIRtfqN/wsLop+6YM4SZ9rWss/bWdYq0Za6BFB2maF6dhS53Uxs5auOFof9vhqZkGGfRAdo1jJpGugJkP1IJCNa/L54OATVMkJdj58gIaW3FTVPFJkCgYEAu6QUojIyWiUzksy8YEAyPNtyoO99Tr+kcQE+upHU0WXKEPkWKimJJxbE/PrE3xPjr8Ph/+eIy/ysMZHFDXBBcv/wKJjZgQ1TGhVHgS6InpiRqzSBJpYlFRqvzbPHOOXgwqGZU9uyh9Ts5ISkrVBbfc0V3gbCqmesmt5EwHbBWkkCgYBn1Sf3yZC4CIhBudopBgK6fEnHbK3c487sJMBLY/SmmZ/Xcw9Qz0oLai7SjJuFW69gY6pTxeshZ+pFJaTUsfVGIQ6BQICwX8gYOFE9IbWATySE4OO0vf11Dcl9fANmnkN5CDhSzyyWHCLeVxyEtNuWr1a/aOWWK+9ErdCkgPyHOQKBgH3N3eeyaQQZuEpThxFbqcYkcHJHAEPBc6a3lTrpMtLZeALrjDIVZZEkQR0U/Ir4ffjOLe1TKNjtiGVHIu17PuyMfcDzLnfJ6Guym0Hhc/N2t43/4HfwxeC0HJPzzJyO3HOK8SMKSmOlm0W8BxjCWExrBWF6aRbMUfFsR27EH2aO
902468ff-6854-484f-b0f3-0f4d958014b0	b8476e9c-3217-46d0-8553-dd7dedb544d5	algorithm	RSA-OAEP
d7a04c34-ddff-4813-a4b2-1f72018092ec	b8476e9c-3217-46d0-8553-dd7dedb544d5	keyUse	ENC
b1a65fac-f4e2-406d-aa05-66f65f31d323	ee1f2cc1-4412-4d0a-b5a6-f668767d497f	kid	eff3af23-dd7b-4b77-b789-c8075c84d373
89618243-c03c-44a1-9779-3d4699c72bab	ee1f2cc1-4412-4d0a-b5a6-f668767d497f	priority	100
554e0401-8e4a-48ff-a27b-2ef5e8a07c89	ee1f2cc1-4412-4d0a-b5a6-f668767d497f	algorithm	HS512
5055cf49-a937-4604-888d-820e6e1e2db0	ee1f2cc1-4412-4d0a-b5a6-f668767d497f	secret	4gpm0DYNZX3NaGDYBbxbMGTyBqPq-LkMgjWEDx48whoVi50XKh_p4VbZbwErRQiasjbSxNsevs6VlSvNL9j92uiHQjYmr08EzhL5rw17EpvRjf_xKXDfVxisOz8eNaJGugEoYL6b8SCFTfs_DBLgPp-sB0aFpwOHzrx8lO7X8G0
695f5617-8e3a-47d5-b597-e72576efb590	bc370621-519c-4d65-baa3-5ee5b0e5ed7d	secret	WXuYUtEwFYn9Qm20HKBhPA
7df4afbc-f920-4801-bcfb-63e090fcf17a	bc370621-519c-4d65-baa3-5ee5b0e5ed7d	kid	066b5014-8ff1-42a2-9bed-25c1a9ed6df4
ffa3da19-6fbf-4116-b7d7-23e0a4ea528b	bc370621-519c-4d65-baa3-5ee5b0e5ed7d	priority	100
71ea8c6b-d002-47e6-afc7-260c040de076	3fb58177-8857-4f50-83a5-713e461598f6	host-sending-registration-request-must-match	true
97356058-ab28-4d1a-a02f-ad2fb6fed2ae	3fb58177-8857-4f50-83a5-713e461598f6	client-uris-must-match	true
bea42b7b-62aa-40f7-892a-29f5c28fff65	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	saml-user-property-mapper
4fd83fb7-2b76-4d8e-8b7b-7eb4576c13b2	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	saml-role-list-mapper
25f14685-3345-439e-b445-3d54606bbb58	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	saml-user-attribute-mapper
2d25237a-ef21-46cc-afda-90bf8768fbf1	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	oidc-full-name-mapper
37c15a16-8c12-4762-b110-a85b140c3804	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	oidc-address-mapper
1cb64bc9-7d30-44b6-804d-6ef969c75fd4	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2b0f32ef-b42a-4032-861e-125ebf04c7c2	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
03c282c7-fc03-4c94-b5b4-869c6e582514	864a99f5-81c9-4bad-887b-0d7c83187d83	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c896b35a-bfd6-4279-b9e3-c8e5ff6c65e7	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	saml-role-list-mapper
a6d9358e-6530-47ee-8c75-6dcf6c6c943a	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8e87b023-ce7c-4d22-bbd7-11a40240a5b9	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f59fbd1c-f5a2-4d47-a7f9-4dbd57179fcd	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	saml-user-property-mapper
2c0b44c7-ae70-4794-8b21-834804ec1ce8	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	oidc-address-mapper
accd3a6b-0079-4e6c-8c1d-c81fc3ce85df	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a81ac1da-1332-48cc-86f3-6bf32df18cac	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	oidc-full-name-mapper
f223e1e9-9a1d-4ee0-b80f-ea0f76e92f5c	fd844c0b-2b3f-47b4-9e68-b6a123d14635	allowed-protocol-mapper-types	saml-user-attribute-mapper
440b8a1e-32f2-476f-9cf9-5a0111d27662	21da5447-c016-4884-9f68-594ca6809571	allow-default-scopes	true
c12d0697-6aca-4b44-9e45-a31140f13ef7	7149067f-d78d-4828-9239-df1ca2ee7348	max-clients	200
05358ea9-5f9b-464f-bcc5-4569bb36d97c	b5a13346-ccc3-4d64-9288-a26947e3c152	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	980b29e6-8893-46d1-a749-e67d063209a7
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	dde03051-817c-4bc6-8d6e-08a776959701
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	1c380337-d7e4-4eac-afb5-19ea36f5df55
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	35f9feb2-1013-4b45-ba3d-9aaeed16516d
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	9220c48f-f540-46eb-91cc-470cc210eb10
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	e8c77cfa-c9af-40dc-87bc-6e2690c393be
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	f9b3cec7-cf39-4a0a-b4c8-7c68618c91f1
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	aab05055-8827-4458-8090-f2d3e4f260cd
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	eb5c8481-a3dc-4187-a9cd-88e6ae66ec0c
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	32e325a6-1051-44f6-9703-ee2aec7c40be
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	06d17eb7-1893-4859-965a-dc334fdcb703
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	29dbfd45-ed7e-4cb5-952f-7b70bb0e1400
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	fd2dd733-ec67-4336-a193-09a934fde930
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	e8d005ce-9374-4654-9d37-aa64f870c588
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	042055b4-b081-43fb-82d3-a7e8b64fd422
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	946798d3-fd79-4927-a3d1-cc3578d48090
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	b2fce532-735e-455d-8063-359e04c207b8
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	d4ee137a-0460-413b-a08f-4bd153068961
35f9feb2-1013-4b45-ba3d-9aaeed16516d	d4ee137a-0460-413b-a08f-4bd153068961
35f9feb2-1013-4b45-ba3d-9aaeed16516d	042055b4-b081-43fb-82d3-a7e8b64fd422
9220c48f-f540-46eb-91cc-470cc210eb10	946798d3-fd79-4927-a3d1-cc3578d48090
9491f30d-f8f4-42c8-9581-d918f4ca9149	564c3396-b88f-47db-858a-e42d152eb15f
9491f30d-f8f4-42c8-9581-d918f4ca9149	a1701b2b-b554-4ca8-857b-267be6442e03
a1701b2b-b554-4ca8-857b-267be6442e03	5cb26b99-accd-482a-8fb8-ebfa11898f75
5d89c58c-499d-427c-8cea-46a765f37eac	be543ef2-301d-46dc-811b-b02a2805b46a
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	772274b2-706b-450c-bc4c-67a14ed8f96d
9491f30d-f8f4-42c8-9581-d918f4ca9149	f131ac38-dd84-49e4-a1b4-acbd717383ed
9491f30d-f8f4-42c8-9581-d918f4ca9149	17e042d0-42b3-4eb8-ba6c-f00b7fd47227
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	42568722-9506-4ddf-911b-7ee82b465992
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	ed34c10d-036b-457a-86d2-16690329d20e
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	02dc0e33-c4ba-4ed1-934a-45643850fc83
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	c8ea3c2d-7ca7-4cd4-8c8d-3b1d349da1c6
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	444ab0a2-07fb-49b1-b701-fbc4dbc6a371
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	1c05a0ea-9895-400f-8dfb-cbc15aa80aa4
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	5d3a2aa3-3bc3-43df-b650-1b23982900d9
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	f6895c18-35c6-4059-a03f-126f6d7ac1c9
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	a1f8fbda-1c36-4e4b-aa35-394b4ebe975b
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	70bbf378-9e63-4cf5-8450-07e5721a0dd5
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	3688fa0d-4bf0-43d2-894e-fad1775fea84
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	014bc0aa-1536-404f-81d7-649758323b83
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	6007177d-285a-4b0b-a314-191166f2ce9e
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	af8b109f-e1ed-4229-a434-a278529f8d30
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	29a07df8-47f9-4706-886c-d93e66da39bc
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	94b0bed5-35d4-4ac3-90fb-afe2322a1a68
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	9ca077bb-8616-4e30-9a01-2547e2e5b5f6
02dc0e33-c4ba-4ed1-934a-45643850fc83	af8b109f-e1ed-4229-a434-a278529f8d30
02dc0e33-c4ba-4ed1-934a-45643850fc83	9ca077bb-8616-4e30-9a01-2547e2e5b5f6
c8ea3c2d-7ca7-4cd4-8c8d-3b1d349da1c6	29a07df8-47f9-4706-886c-d93e66da39bc
97e06049-f831-493a-8d99-3530834866ac	13319db9-91e0-487a-8c21-5aedf74e510c
97e06049-f831-493a-8d99-3530834866ac	94ec3b9b-35ca-4603-a117-cc2525b43c9e
97e06049-f831-493a-8d99-3530834866ac	eda6e11b-53da-4d20-bf38-201604642208
97e06049-f831-493a-8d99-3530834866ac	382b0a01-2c53-45b8-a540-4f51995880c5
97e06049-f831-493a-8d99-3530834866ac	b3b1924a-bd30-447e-ba09-8a275661c885
97e06049-f831-493a-8d99-3530834866ac	09528596-e5df-402e-8a41-a484ba7491d8
97e06049-f831-493a-8d99-3530834866ac	50b628e7-d2ad-42d9-a060-87fc0b6ce6d7
97e06049-f831-493a-8d99-3530834866ac	ab308a02-4fa8-4ec3-8815-695d3e452a3d
97e06049-f831-493a-8d99-3530834866ac	1d048b67-5baa-480a-8f86-fab3d80cfaba
97e06049-f831-493a-8d99-3530834866ac	609a0ab7-96b8-4d1d-ac5e-a4d4f88752cf
97e06049-f831-493a-8d99-3530834866ac	616aba1b-36cf-44c0-8621-5cfb55490e25
97e06049-f831-493a-8d99-3530834866ac	d520d1cd-51dc-4d7d-87d8-e3131347a8ac
97e06049-f831-493a-8d99-3530834866ac	638fd6ca-ada8-4f0d-b97b-e1ad50749afe
97e06049-f831-493a-8d99-3530834866ac	cec29e5c-91a3-4add-9bf6-a52532593ccd
97e06049-f831-493a-8d99-3530834866ac	0d8ea86d-34ca-4839-8df0-9ca7ae93f70f
97e06049-f831-493a-8d99-3530834866ac	c684de78-3711-462f-bbbd-cbc670650b3d
97e06049-f831-493a-8d99-3530834866ac	357806ad-5e59-4a55-8b33-5b03101d3648
2e66ac80-d139-4244-b0d3-757c649a4fe3	ec316d32-3664-477f-80a1-69b568d11ef3
382b0a01-2c53-45b8-a540-4f51995880c5	0d8ea86d-34ca-4839-8df0-9ca7ae93f70f
eda6e11b-53da-4d20-bf38-201604642208	cec29e5c-91a3-4add-9bf6-a52532593ccd
eda6e11b-53da-4d20-bf38-201604642208	357806ad-5e59-4a55-8b33-5b03101d3648
2e66ac80-d139-4244-b0d3-757c649a4fe3	280b4873-eb65-430c-97ee-99f91a06b0d9
280b4873-eb65-430c-97ee-99f91a06b0d9	96ca0111-1547-4eab-9df4-84747fa047b2
66c53e31-3abd-4abf-a539-3e58e8a04645	6fe39e49-4766-4653-b7bc-ac89d82ee09c
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	9d80930e-af6f-498d-897b-065d62b7404f
97e06049-f831-493a-8d99-3530834866ac	917876b5-dec9-4881-8c28-f23c5a364af9
2e66ac80-d139-4244-b0d3-757c649a4fe3	5a5d71e3-f2c0-412a-9955-d3d0e76af2fb
2e66ac80-d139-4244-b0d3-757c649a4fe3	4c3dc6d9-502b-4fd9-aa9e-132da1b29951
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
4a49058a-024f-43ad-8078-09fe09ac8193	\N	password	9f1502b9-3dc8-4feb-9af1-7e6d2ecbb203	1720096837151	My password	{"value":"zPvWvMWIkfeOWE9gIryin6XwZC78nWRr5qZaOSNx2ak=","salt":"4YHeAu9XZftM1/JgsKJyaw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
f0fbc14b-47b1-4dc8-a651-f54ad1aa0ef0	\N	password	02ebcdd8-7697-4a8b-bbd5-124359173db0	1720096978780	My password	{"value":"qmq76FjtxV009FTa9eYfgdKjFifpqDuxYQhNt7/u6nQ=","salt":"hfOnxQe5H2b70F1UTI7OEw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-07-04 12:00:06.710119	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	0094406417
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-07-04 12:00:06.730162	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	0094406417
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-07-04 12:00:06.77221	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	0094406417
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-07-04 12:00:06.77628	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0094406417
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-07-04 12:00:06.86345	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	0094406417
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-07-04 12:00:06.870726	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	0094406417
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-07-04 12:00:06.938998	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	0094406417
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-07-04 12:00:06.943804	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	0094406417
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-07-04 12:00:06.948407	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	0094406417
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-07-04 12:00:07.00664	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	0094406417
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-07-04 12:00:07.042778	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0094406417
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-07-04 12:00:07.046961	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0094406417
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-07-04 12:00:07.081902	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	0094406417
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-04 12:00:07.095766	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	0094406417
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-04 12:00:07.096996	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-04 12:00:07.099236	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	0094406417
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-04 12:00:07.101441	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	0094406417
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-07-04 12:00:07.129636	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	0094406417
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-07-04 12:00:07.160653	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	0094406417
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-07-04 12:00:07.164135	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	0094406417
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-04 12:00:07.839731	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	0094406417
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-04 12:00:07.167041	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	0094406417
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-04 12:00:07.169214	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	0094406417
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-07-04 12:00:07.187843	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	0094406417
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-07-04 12:00:07.197064	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	0094406417
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-07-04 12:00:07.198251	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	0094406417
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-07-04 12:00:07.217141	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	0094406417
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-07-04 12:00:07.262344	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	0094406417
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-07-04 12:00:07.264885	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	0094406417
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-07-04 12:00:07.305193	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	0094406417
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-07-04 12:00:07.315159	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	0094406417
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-07-04 12:00:07.331768	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	0094406417
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-07-04 12:00:07.337968	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	0094406417
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-04 12:00:07.345123	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-04 12:00:07.347124	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	0094406417
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-04 12:00:07.369358	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	0094406417
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-07-04 12:00:07.372184	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	0094406417
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-04 12:00:07.375216	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0094406417
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-07-04 12:00:07.37745	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	0094406417
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-07-04 12:00:07.379563	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	0094406417
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-04 12:00:07.380428	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	0094406417
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-04 12:00:07.381771	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	0094406417
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-07-04 12:00:07.386554	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	0094406417
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-04 12:00:07.459719	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	0094406417
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-07-04 12:00:07.462838	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	0094406417
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-04 12:00:07.466025	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	0094406417
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-04 12:00:07.470638	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	0094406417
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-04 12:00:07.471639	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	0094406417
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-04 12:00:07.49322	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	0094406417
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-04 12:00:07.49621	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	0094406417
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-07-04 12:00:07.517641	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	0094406417
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-07-04 12:00:07.533613	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	0094406417
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-07-04 12:00:07.535783	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-07-04 12:00:07.537624	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	0094406417
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-07-04 12:00:07.539392	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	0094406417
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-04 12:00:07.54305	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	0094406417
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-04 12:00:07.545875	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	0094406417
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-04 12:00:07.55768	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	0094406417
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-04 12:00:07.610535	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	0094406417
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-07-04 12:00:07.62484	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	0094406417
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-07-04 12:00:07.628256	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	0094406417
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-04 12:00:07.634223	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	0094406417
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-04 12:00:07.637265	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	0094406417
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-07-04 12:00:07.639383	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	0094406417
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-07-04 12:00:07.64119	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	0094406417
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-04 12:00:07.643001	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	0094406417
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-07-04 12:00:07.649662	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	0094406417
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-04 12:00:07.652566	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	0094406417
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-07-04 12:00:07.655241	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	0094406417
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-07-04 12:00:07.662871	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	0094406417
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-07-04 12:00:07.666154	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	0094406417
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-07-04 12:00:07.66855	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	0094406417
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-04 12:00:07.672836	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0094406417
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-04 12:00:07.677488	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0094406417
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-04 12:00:07.679028	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	0094406417
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-04 12:00:07.689822	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	0094406417
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-04 12:00:07.693523	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	0094406417
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-04 12:00:07.695817	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	0094406417
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-04 12:00:07.696743	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	0094406417
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-04 12:00:07.706224	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	0094406417
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-04 12:00:07.707399	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	0094406417
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-04 12:00:07.710815	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	0094406417
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-04 12:00:07.711736	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0094406417
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-04 12:00:07.714548	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0094406417
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-04 12:00:07.715425	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	0094406417
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-04 12:00:07.718733	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0094406417
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-07-04 12:00:07.721413	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	0094406417
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-04 12:00:07.725297	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	0094406417
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-04 12:00:07.729962	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	0094406417
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.734787	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	0094406417
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.738375	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	0094406417
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.741838	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.746069	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	0094406417
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.74703	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	0094406417
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.751604	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	0094406417
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.752735	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	0094406417
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-04 12:00:07.756439	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	0094406417
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.761937	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.762898	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.770609	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.774923	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.776032	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.779707	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	0094406417
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-04 12:00:07.783904	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	0094406417
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-07-04 12:00:07.7877	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	0094406417
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-07-04 12:00:07.790868	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	0094406417
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-07-04 12:00:07.793818	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	0094406417
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-07-04 12:00:07.797973	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	0094406417
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-04 12:00:07.800893	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	0094406417
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-04 12:00:07.801718	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	0094406417
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-04 12:00:07.804853	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-07-04 12:00:07.807758	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	0094406417
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-04 12:00:07.819626	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	0094406417
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-04 12:00:07.821145	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	0094406417
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-04 12:00:07.824329	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	0094406417
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-04 12:00:07.825044	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	0094406417
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-04 12:00:07.828018	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	0094406417
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-04 12:00:07.829589	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	0094406417
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-04 12:00:07.83683	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	0094406417
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-04 12:00:07.842312	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-04 12:00:07.845331	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-04 12:00:07.847986	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	0094406417
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-04 12:00:07.848716	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-04 12:00:07.849646	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	0094406417
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.852009	125	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	0094406417
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.854542	126	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.856979	127	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	0094406417
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.857973	128	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.860877	129	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	0094406417
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.869823	130	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	0094406417
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.87609	131	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	0094406417
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.877022	132	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	0094406417
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-04 12:00:07.880738	133	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	0094406417
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
2eca1426-cce8-48c4-a944-90aa859476ff	3933f10c-2bee-47ef-8fc2-19c3939753ab	f
2eca1426-cce8-48c4-a944-90aa859476ff	10651b1e-f454-4a13-8519-8c102b3d94db	t
2eca1426-cce8-48c4-a944-90aa859476ff	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3	t
2eca1426-cce8-48c4-a944-90aa859476ff	f13d8b38-140f-4d5f-88fb-a07b008ea6c5	t
2eca1426-cce8-48c4-a944-90aa859476ff	070f9656-1da4-4dba-bb7f-479f1d3cbec5	f
2eca1426-cce8-48c4-a944-90aa859476ff	d92fbce2-8e26-439e-9cc3-bdc7d5886160	f
2eca1426-cce8-48c4-a944-90aa859476ff	1268d73b-8909-4d13-ba86-b37057d7f220	t
2eca1426-cce8-48c4-a944-90aa859476ff	68d802c9-9b18-45dd-87d2-873e1bf4915f	t
2eca1426-cce8-48c4-a944-90aa859476ff	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c	f
2eca1426-cce8-48c4-a944-90aa859476ff	a4da603e-292f-48e3-a837-0f766babe061	t
2eca1426-cce8-48c4-a944-90aa859476ff	53a294d3-c294-4e23-be32-ffc0919802b9	t
00164430-588c-4b7e-a550-cedd315756a4	85c5538e-dcab-4213-ac39-c73b92b87d43	f
00164430-588c-4b7e-a550-cedd315756a4	0136e6e0-6bb7-4294-aa97-dcdfc6236c8e	t
00164430-588c-4b7e-a550-cedd315756a4	7ac1c79c-3432-42e2-9135-97e14b21f6a1	t
00164430-588c-4b7e-a550-cedd315756a4	be05d157-5141-4a9a-88a4-039c7146f4d9	t
00164430-588c-4b7e-a550-cedd315756a4	f81b3188-6f69-46e1-af62-e368b29dd280	f
00164430-588c-4b7e-a550-cedd315756a4	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c	f
00164430-588c-4b7e-a550-cedd315756a4	46158d19-b10d-46f5-ad2f-8412cd724345	t
00164430-588c-4b7e-a550-cedd315756a4	b7fa39a6-aac0-4027-acca-4573889cf7c5	t
00164430-588c-4b7e-a550-cedd315756a4	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52	f
00164430-588c-4b7e-a550-cedd315756a4	7894e9db-2712-4e69-b766-64f4039693b0	t
00164430-588c-4b7e-a550-cedd315756a4	5a99b4fc-fab6-41c6-ad86-425543435650	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9491f30d-f8f4-42c8-9581-d918f4ca9149	2eca1426-cce8-48c4-a944-90aa859476ff	f	${role_default-roles}	default-roles-master	2eca1426-cce8-48c4-a944-90aa859476ff	\N	\N
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	2eca1426-cce8-48c4-a944-90aa859476ff	f	${role_admin}	admin	2eca1426-cce8-48c4-a944-90aa859476ff	\N	\N
980b29e6-8893-46d1-a749-e67d063209a7	2eca1426-cce8-48c4-a944-90aa859476ff	f	${role_create-realm}	create-realm	2eca1426-cce8-48c4-a944-90aa859476ff	\N	\N
dde03051-817c-4bc6-8d6e-08a776959701	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_create-client}	create-client	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
1c380337-d7e4-4eac-afb5-19ea36f5df55	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-realm}	view-realm	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
35f9feb2-1013-4b45-ba3d-9aaeed16516d	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-users}	view-users	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
9220c48f-f540-46eb-91cc-470cc210eb10	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-clients}	view-clients	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
e8c77cfa-c9af-40dc-87bc-6e2690c393be	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-events}	view-events	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
f9b3cec7-cf39-4a0a-b4c8-7c68618c91f1	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-identity-providers}	view-identity-providers	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
aab05055-8827-4458-8090-f2d3e4f260cd	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_view-authorization}	view-authorization	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
eb5c8481-a3dc-4187-a9cd-88e6ae66ec0c	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-realm}	manage-realm	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
32e325a6-1051-44f6-9703-ee2aec7c40be	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-users}	manage-users	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
06d17eb7-1893-4859-965a-dc334fdcb703	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-clients}	manage-clients	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
29dbfd45-ed7e-4cb5-952f-7b70bb0e1400	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-events}	manage-events	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
fd2dd733-ec67-4336-a193-09a934fde930	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-identity-providers}	manage-identity-providers	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
e8d005ce-9374-4654-9d37-aa64f870c588	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_manage-authorization}	manage-authorization	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
042055b4-b081-43fb-82d3-a7e8b64fd422	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_query-users}	query-users	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
946798d3-fd79-4927-a3d1-cc3578d48090	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_query-clients}	query-clients	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
b2fce532-735e-455d-8063-359e04c207b8	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_query-realms}	query-realms	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
d4ee137a-0460-413b-a08f-4bd153068961	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_query-groups}	query-groups	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
564c3396-b88f-47db-858a-e42d152eb15f	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_view-profile}	view-profile	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
a1701b2b-b554-4ca8-857b-267be6442e03	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_manage-account}	manage-account	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
5cb26b99-accd-482a-8fb8-ebfa11898f75	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_manage-account-links}	manage-account-links	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
16d72ff6-7faf-4ad5-aa79-8cc8aba8afa0	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_view-applications}	view-applications	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
be543ef2-301d-46dc-811b-b02a2805b46a	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_view-consent}	view-consent	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
5d89c58c-499d-427c-8cea-46a765f37eac	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_manage-consent}	manage-consent	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
073c555d-87bf-4edf-b681-f368d7134717	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_view-groups}	view-groups	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
08685d38-788f-4dde-9e05-5ae993ac2af9	c1e8118b-364d-422d-93f6-03d6e6ef9feb	t	${role_delete-account}	delete-account	2eca1426-cce8-48c4-a944-90aa859476ff	c1e8118b-364d-422d-93f6-03d6e6ef9feb	\N
a1f06ad3-5301-4494-8a30-a37dea008a3e	eb2f3da9-5568-446b-a1eb-0a05c8987d19	t	${role_read-token}	read-token	2eca1426-cce8-48c4-a944-90aa859476ff	eb2f3da9-5568-446b-a1eb-0a05c8987d19	\N
772274b2-706b-450c-bc4c-67a14ed8f96d	6d49f9d7-5c39-403e-8651-b349982997c6	t	${role_impersonation}	impersonation	2eca1426-cce8-48c4-a944-90aa859476ff	6d49f9d7-5c39-403e-8651-b349982997c6	\N
f131ac38-dd84-49e4-a1b4-acbd717383ed	2eca1426-cce8-48c4-a944-90aa859476ff	f	${role_offline-access}	offline_access	2eca1426-cce8-48c4-a944-90aa859476ff	\N	\N
17e042d0-42b3-4eb8-ba6c-f00b7fd47227	2eca1426-cce8-48c4-a944-90aa859476ff	f	${role_uma_authorization}	uma_authorization	2eca1426-cce8-48c4-a944-90aa859476ff	\N	\N
2e66ac80-d139-4244-b0d3-757c649a4fe3	00164430-588c-4b7e-a550-cedd315756a4	f	${role_default-roles}	default-roles-apache-realm	00164430-588c-4b7e-a550-cedd315756a4	\N	\N
42568722-9506-4ddf-911b-7ee82b465992	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_create-client}	create-client	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
ed34c10d-036b-457a-86d2-16690329d20e	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-realm}	view-realm	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
02dc0e33-c4ba-4ed1-934a-45643850fc83	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-users}	view-users	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
c8ea3c2d-7ca7-4cd4-8c8d-3b1d349da1c6	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-clients}	view-clients	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
444ab0a2-07fb-49b1-b701-fbc4dbc6a371	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-events}	view-events	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
1c05a0ea-9895-400f-8dfb-cbc15aa80aa4	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-identity-providers}	view-identity-providers	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
5d3a2aa3-3bc3-43df-b650-1b23982900d9	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_view-authorization}	view-authorization	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
f6895c18-35c6-4059-a03f-126f6d7ac1c9	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-realm}	manage-realm	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
a1f8fbda-1c36-4e4b-aa35-394b4ebe975b	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-users}	manage-users	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
70bbf378-9e63-4cf5-8450-07e5721a0dd5	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-clients}	manage-clients	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
3688fa0d-4bf0-43d2-894e-fad1775fea84	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-events}	manage-events	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
014bc0aa-1536-404f-81d7-649758323b83	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-identity-providers}	manage-identity-providers	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
6007177d-285a-4b0b-a314-191166f2ce9e	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_manage-authorization}	manage-authorization	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
af8b109f-e1ed-4229-a434-a278529f8d30	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_query-users}	query-users	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
29a07df8-47f9-4706-886c-d93e66da39bc	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_query-clients}	query-clients	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
94b0bed5-35d4-4ac3-90fb-afe2322a1a68	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_query-realms}	query-realms	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
9ca077bb-8616-4e30-9a01-2547e2e5b5f6	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_query-groups}	query-groups	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
97e06049-f831-493a-8d99-3530834866ac	75041075-d112-404a-ad59-16fae2dbb663	t	${role_realm-admin}	realm-admin	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
13319db9-91e0-487a-8c21-5aedf74e510c	75041075-d112-404a-ad59-16fae2dbb663	t	${role_create-client}	create-client	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
94ec3b9b-35ca-4603-a117-cc2525b43c9e	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-realm}	view-realm	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
eda6e11b-53da-4d20-bf38-201604642208	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-users}	view-users	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
382b0a01-2c53-45b8-a540-4f51995880c5	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-clients}	view-clients	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
b3b1924a-bd30-447e-ba09-8a275661c885	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-events}	view-events	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
09528596-e5df-402e-8a41-a484ba7491d8	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-identity-providers}	view-identity-providers	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
50b628e7-d2ad-42d9-a060-87fc0b6ce6d7	75041075-d112-404a-ad59-16fae2dbb663	t	${role_view-authorization}	view-authorization	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
ab308a02-4fa8-4ec3-8815-695d3e452a3d	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-realm}	manage-realm	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
1d048b67-5baa-480a-8f86-fab3d80cfaba	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-users}	manage-users	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
609a0ab7-96b8-4d1d-ac5e-a4d4f88752cf	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-clients}	manage-clients	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
616aba1b-36cf-44c0-8621-5cfb55490e25	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-events}	manage-events	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
d520d1cd-51dc-4d7d-87d8-e3131347a8ac	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-identity-providers}	manage-identity-providers	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
638fd6ca-ada8-4f0d-b97b-e1ad50749afe	75041075-d112-404a-ad59-16fae2dbb663	t	${role_manage-authorization}	manage-authorization	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
cec29e5c-91a3-4add-9bf6-a52532593ccd	75041075-d112-404a-ad59-16fae2dbb663	t	${role_query-users}	query-users	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
0d8ea86d-34ca-4839-8df0-9ca7ae93f70f	75041075-d112-404a-ad59-16fae2dbb663	t	${role_query-clients}	query-clients	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
c684de78-3711-462f-bbbd-cbc670650b3d	75041075-d112-404a-ad59-16fae2dbb663	t	${role_query-realms}	query-realms	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
357806ad-5e59-4a55-8b33-5b03101d3648	75041075-d112-404a-ad59-16fae2dbb663	t	${role_query-groups}	query-groups	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
ec316d32-3664-477f-80a1-69b568d11ef3	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_view-profile}	view-profile	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
280b4873-eb65-430c-97ee-99f91a06b0d9	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_manage-account}	manage-account	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
96ca0111-1547-4eab-9df4-84747fa047b2	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_manage-account-links}	manage-account-links	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
043ac580-5e55-46cf-8796-1a4bc70c5a08	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_view-applications}	view-applications	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
6fe39e49-4766-4653-b7bc-ac89d82ee09c	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_view-consent}	view-consent	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
66c53e31-3abd-4abf-a539-3e58e8a04645	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_manage-consent}	manage-consent	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
efd25779-b7d7-4026-ba40-d51d69bdfe03	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_view-groups}	view-groups	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
acd1f382-2503-4a58-bf00-9d976bed9e0a	d2900d29-9eee-4985-b398-9b1d9908b742	t	${role_delete-account}	delete-account	00164430-588c-4b7e-a550-cedd315756a4	d2900d29-9eee-4985-b398-9b1d9908b742	\N
9d80930e-af6f-498d-897b-065d62b7404f	3e84fc6e-f844-432d-b205-1bd1b8255474	t	${role_impersonation}	impersonation	2eca1426-cce8-48c4-a944-90aa859476ff	3e84fc6e-f844-432d-b205-1bd1b8255474	\N
917876b5-dec9-4881-8c28-f23c5a364af9	75041075-d112-404a-ad59-16fae2dbb663	t	${role_impersonation}	impersonation	00164430-588c-4b7e-a550-cedd315756a4	75041075-d112-404a-ad59-16fae2dbb663	\N
0fcf8a59-0a44-40c9-8e96-714ab1fd8369	e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	t	${role_read-token}	read-token	00164430-588c-4b7e-a550-cedd315756a4	e53d19aa-0cb4-4db7-b43c-27f09a7d8a69	\N
5a5d71e3-f2c0-412a-9955-d3d0e76af2fb	00164430-588c-4b7e-a550-cedd315756a4	f	${role_offline-access}	offline_access	00164430-588c-4b7e-a550-cedd315756a4	\N	\N
4c3dc6d9-502b-4fd9-aa9e-132da1b29951	00164430-588c-4b7e-a550-cedd315756a4	f	${role_uma_authorization}	uma_authorization	00164430-588c-4b7e-a550-cedd315756a4	\N	\N
a1a0f7e6-ca57-48d9-ab0e-cc08aa9a7084	305eeea6-c469-4d38-a79b-df23ef9f25da	t	\N	uma_protection	00164430-588c-4b7e-a550-cedd315756a4	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
8cfhu	25.0.1	1720094408
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
aa9e7b0e-f4a7-4e0d-a3dd-8c5c75ce8bf1	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
df17ed78-2177-4bb0-8115-8753b10e25b3	defaultResourceType	urn:apache:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
7809c564-6eab-43dc-b0fa-c614079628bd	audience resolve	openid-connect	oidc-audience-resolve-mapper	d4b85b39-6674-433d-844b-6a8d39d8ecce	\N
7d6dce77-8129-46ac-8160-a196be0f5a64	locale	openid-connect	oidc-usermodel-attribute-mapper	83d065c1-c30e-4b10-8e1d-399a201d4805	\N
00bbcbbc-7428-4c9e-979c-1dc2473ebf4c	role list	saml	saml-role-list-mapper	\N	10651b1e-f454-4a13-8519-8c102b3d94db
6124aaed-3dfb-4e64-aa20-b466118345fe	full name	openid-connect	oidc-full-name-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
d43fc5ec-5b36-45d2-ba50-89e92e122087	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
3e1e98ac-e034-4085-ad94-641dff788bfa	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
2ef7dac3-e576-43ec-b93a-5eac94f8c946	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	username	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
7139a379-99de-4e6e-8682-de4522bdf52c	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	website	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
2c79906a-a0d1-40c0-81bb-1641f73d928d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
6c5ff606-b780-47bf-8421-fb1c8fd70de7	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
336684f0-4ce4-4c0d-8875-ecef8e165672	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
e785039e-e039-4260-a927-d1daa4c63f98	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
296a184d-229a-4e8a-9743-b32674ca16b8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	c1a0ee5a-83e0-4e15-8846-00d5fa55e2c3
b7718c3a-5e77-43dc-9419-7641b2b8355e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	f13d8b38-140f-4d5f-88fb-a07b008ea6c5
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f13d8b38-140f-4d5f-88fb-a07b008ea6c5
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	address	openid-connect	oidc-address-mapper	\N	070f9656-1da4-4dba-bb7f-479f1d3cbec5
3451e4ed-a933-4927-ad7a-1f9746476501	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d92fbce2-8e26-439e-9cc3-bdc7d5886160
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d92fbce2-8e26-439e-9cc3-bdc7d5886160
c1434edd-0106-4d19-a155-7ab1d532644d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	1268d73b-8909-4d13-ba86-b37057d7f220
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	1268d73b-8909-4d13-ba86-b37057d7f220
dc22b363-a9b3-42e5-981b-d1ef94f55239	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	1268d73b-8909-4d13-ba86-b37057d7f220
a4ef4717-a80a-4ab2-b4ba-bcfe85470cbb	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	68d802c9-9b18-45dd-87d2-873e1bf4915f
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c
96fd5608-831d-4ce1-844f-2b6413fb3c76	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	410fc3d2-cf2b-4a18-b3e6-c451f1fa243c
ee1f2e56-a49c-4faf-b421-42fc2921f925	acr loa level	openid-connect	oidc-acr-mapper	\N	a4da603e-292f-48e3-a837-0f766babe061
fd45deca-d423-4691-9ebb-159a8db80182	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	53a294d3-c294-4e23-be32-ffc0919802b9
86c54862-47f4-4dbc-adab-de014d4ae93b	sub	openid-connect	oidc-sub-mapper	\N	53a294d3-c294-4e23-be32-ffc0919802b9
3bf0b3c7-f7bf-4d03-810a-ec1b0aef16da	audience resolve	openid-connect	oidc-audience-resolve-mapper	6eed25a6-533d-42d1-a2b7-385062550518	\N
d7b1b9d4-4505-4593-aad5-b059218d47d5	role list	saml	saml-role-list-mapper	\N	0136e6e0-6bb7-4294-aa97-dcdfc6236c8e
6b3465df-0365-4237-9000-005561f21da4	full name	openid-connect	oidc-full-name-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
a5e439f3-32a8-4d2a-8d80-7371513621d3	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
b39476df-9072-46bb-857d-8ac3bb492b0e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
29c8707f-8979-4a25-bec6-890f83577012	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	username	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
875829c7-6c7f-429b-9273-784984235722	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
b53d1a7c-1de4-41c1-af18-34357d9e1056	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
f296161b-f90d-4573-af79-07a3dea3ac04	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
6ec9d846-ab7b-4b53-8b56-78f0df938b44	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
16183585-bfb7-4e77-b648-ca47fb3165f5	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
417feef3-b788-4456-9628-46dab243f848	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
e04f7395-0117-4d2a-b824-b0df5d7484d8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7ac1c79c-3432-42e2-9135-97e14b21f6a1
19afa6dd-1430-430e-8421-4b5bd5ec0909	email	openid-connect	oidc-usermodel-attribute-mapper	\N	be05d157-5141-4a9a-88a4-039c7146f4d9
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	email verified	openid-connect	oidc-usermodel-property-mapper	\N	be05d157-5141-4a9a-88a4-039c7146f4d9
70977daa-8cbe-450a-9545-e9e16d0e06ad	address	openid-connect	oidc-address-mapper	\N	f81b3188-6f69-46e1-af62-e368b29dd280
ca4c33bd-b107-4a99-a672-baf6edc03a11	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	0b7d0685-15d0-4f2d-b9c7-b66a7fab682c
3c635780-a462-4b50-ac10-aeb9cd34b4ee	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	46158d19-b10d-46f5-ad2f-8412cd724345
7a162631-5017-4f77-a05b-727aeee7bf6a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	46158d19-b10d-46f5-ad2f-8412cd724345
08c820de-4414-4909-93e3-640f67935962	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	46158d19-b10d-46f5-ad2f-8412cd724345
9fa5cebd-f89d-4cc2-8938-c68174b67630	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b7fa39a6-aac0-4027-acca-4573889cf7c5
9495243a-0ebc-4909-8522-9429bd09988c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52
7454eb51-6055-4a11-89b7-ac5e22f76545	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	8384ba9f-b4bf-4f29-be1c-8a87e7c21b52
ff46743a-5448-4960-b8b4-e3213b5abd2e	acr loa level	openid-connect	oidc-acr-mapper	\N	7894e9db-2712-4e69-b766-64f4039693b0
e68751b0-44b9-4d8a-82b3-7d6911188be2	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	5a99b4fc-fab6-41c6-ad86-425543435650
76d0813b-4779-4a55-8fee-8b605ccf47e3	sub	openid-connect	oidc-sub-mapper	\N	5a99b4fc-fab6-41c6-ad86-425543435650
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	locale	openid-connect	oidc-usermodel-attribute-mapper	33a02fbc-ce94-41de-bea8-afedd6f6b780	\N
47140054-0d62-433b-a95a-87cdf7b888cc	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
82bd1d42-0986-4df7-ade2-212d393191a0	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
55195dc4-5cb3-4ae1-aefe-59e97183734f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
7d6dce77-8129-46ac-8160-a196be0f5a64	true	introspection.token.claim
7d6dce77-8129-46ac-8160-a196be0f5a64	true	userinfo.token.claim
7d6dce77-8129-46ac-8160-a196be0f5a64	locale	user.attribute
7d6dce77-8129-46ac-8160-a196be0f5a64	true	id.token.claim
7d6dce77-8129-46ac-8160-a196be0f5a64	true	access.token.claim
7d6dce77-8129-46ac-8160-a196be0f5a64	locale	claim.name
7d6dce77-8129-46ac-8160-a196be0f5a64	String	jsonType.label
00bbcbbc-7428-4c9e-979c-1dc2473ebf4c	false	single
00bbcbbc-7428-4c9e-979c-1dc2473ebf4c	Basic	attribute.nameformat
00bbcbbc-7428-4c9e-979c-1dc2473ebf4c	Role	attribute.name
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	true	introspection.token.claim
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	true	userinfo.token.claim
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	lastName	user.attribute
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	true	id.token.claim
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	true	access.token.claim
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	family_name	claim.name
0d3c9333-e71d-46c7-858e-fdfa50d3bd5e	String	jsonType.label
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	true	introspection.token.claim
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	true	userinfo.token.claim
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	profile	user.attribute
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	true	id.token.claim
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	true	access.token.claim
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	profile	claim.name
1a6f39bd-b426-453c-86dc-a67b8bcaa7a6	String	jsonType.label
296a184d-229a-4e8a-9743-b32674ca16b8	true	introspection.token.claim
296a184d-229a-4e8a-9743-b32674ca16b8	true	userinfo.token.claim
296a184d-229a-4e8a-9743-b32674ca16b8	updatedAt	user.attribute
296a184d-229a-4e8a-9743-b32674ca16b8	true	id.token.claim
296a184d-229a-4e8a-9743-b32674ca16b8	true	access.token.claim
296a184d-229a-4e8a-9743-b32674ca16b8	updated_at	claim.name
296a184d-229a-4e8a-9743-b32674ca16b8	long	jsonType.label
2c79906a-a0d1-40c0-81bb-1641f73d928d	true	introspection.token.claim
2c79906a-a0d1-40c0-81bb-1641f73d928d	true	userinfo.token.claim
2c79906a-a0d1-40c0-81bb-1641f73d928d	gender	user.attribute
2c79906a-a0d1-40c0-81bb-1641f73d928d	true	id.token.claim
2c79906a-a0d1-40c0-81bb-1641f73d928d	true	access.token.claim
2c79906a-a0d1-40c0-81bb-1641f73d928d	gender	claim.name
2c79906a-a0d1-40c0-81bb-1641f73d928d	String	jsonType.label
2ef7dac3-e576-43ec-b93a-5eac94f8c946	true	introspection.token.claim
2ef7dac3-e576-43ec-b93a-5eac94f8c946	true	userinfo.token.claim
2ef7dac3-e576-43ec-b93a-5eac94f8c946	nickname	user.attribute
2ef7dac3-e576-43ec-b93a-5eac94f8c946	true	id.token.claim
2ef7dac3-e576-43ec-b93a-5eac94f8c946	true	access.token.claim
2ef7dac3-e576-43ec-b93a-5eac94f8c946	nickname	claim.name
2ef7dac3-e576-43ec-b93a-5eac94f8c946	String	jsonType.label
336684f0-4ce4-4c0d-8875-ecef8e165672	true	introspection.token.claim
336684f0-4ce4-4c0d-8875-ecef8e165672	true	userinfo.token.claim
336684f0-4ce4-4c0d-8875-ecef8e165672	zoneinfo	user.attribute
336684f0-4ce4-4c0d-8875-ecef8e165672	true	id.token.claim
336684f0-4ce4-4c0d-8875-ecef8e165672	true	access.token.claim
336684f0-4ce4-4c0d-8875-ecef8e165672	zoneinfo	claim.name
336684f0-4ce4-4c0d-8875-ecef8e165672	String	jsonType.label
3e1e98ac-e034-4085-ad94-641dff788bfa	true	introspection.token.claim
3e1e98ac-e034-4085-ad94-641dff788bfa	true	userinfo.token.claim
3e1e98ac-e034-4085-ad94-641dff788bfa	middleName	user.attribute
3e1e98ac-e034-4085-ad94-641dff788bfa	true	id.token.claim
3e1e98ac-e034-4085-ad94-641dff788bfa	true	access.token.claim
3e1e98ac-e034-4085-ad94-641dff788bfa	middle_name	claim.name
3e1e98ac-e034-4085-ad94-641dff788bfa	String	jsonType.label
6124aaed-3dfb-4e64-aa20-b466118345fe	true	introspection.token.claim
6124aaed-3dfb-4e64-aa20-b466118345fe	true	userinfo.token.claim
6124aaed-3dfb-4e64-aa20-b466118345fe	true	id.token.claim
6124aaed-3dfb-4e64-aa20-b466118345fe	true	access.token.claim
6c5ff606-b780-47bf-8421-fb1c8fd70de7	true	introspection.token.claim
6c5ff606-b780-47bf-8421-fb1c8fd70de7	true	userinfo.token.claim
6c5ff606-b780-47bf-8421-fb1c8fd70de7	birthdate	user.attribute
6c5ff606-b780-47bf-8421-fb1c8fd70de7	true	id.token.claim
6c5ff606-b780-47bf-8421-fb1c8fd70de7	true	access.token.claim
6c5ff606-b780-47bf-8421-fb1c8fd70de7	birthdate	claim.name
6c5ff606-b780-47bf-8421-fb1c8fd70de7	String	jsonType.label
7139a379-99de-4e6e-8682-de4522bdf52c	true	introspection.token.claim
7139a379-99de-4e6e-8682-de4522bdf52c	true	userinfo.token.claim
7139a379-99de-4e6e-8682-de4522bdf52c	picture	user.attribute
7139a379-99de-4e6e-8682-de4522bdf52c	true	id.token.claim
7139a379-99de-4e6e-8682-de4522bdf52c	true	access.token.claim
7139a379-99de-4e6e-8682-de4522bdf52c	picture	claim.name
7139a379-99de-4e6e-8682-de4522bdf52c	String	jsonType.label
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	true	introspection.token.claim
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	true	userinfo.token.claim
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	website	user.attribute
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	true	id.token.claim
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	true	access.token.claim
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	website	claim.name
8fa76398-4628-47b4-a3ae-c72aa9ab54ae	String	jsonType.label
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	true	introspection.token.claim
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	true	userinfo.token.claim
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	username	user.attribute
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	true	id.token.claim
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	true	access.token.claim
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	preferred_username	claim.name
ca1ea4b7-dc80-4913-a521-8b112b0b2a79	String	jsonType.label
d43fc5ec-5b36-45d2-ba50-89e92e122087	true	introspection.token.claim
d43fc5ec-5b36-45d2-ba50-89e92e122087	true	userinfo.token.claim
d43fc5ec-5b36-45d2-ba50-89e92e122087	firstName	user.attribute
d43fc5ec-5b36-45d2-ba50-89e92e122087	true	id.token.claim
d43fc5ec-5b36-45d2-ba50-89e92e122087	true	access.token.claim
d43fc5ec-5b36-45d2-ba50-89e92e122087	given_name	claim.name
d43fc5ec-5b36-45d2-ba50-89e92e122087	String	jsonType.label
e785039e-e039-4260-a927-d1daa4c63f98	true	introspection.token.claim
e785039e-e039-4260-a927-d1daa4c63f98	true	userinfo.token.claim
e785039e-e039-4260-a927-d1daa4c63f98	locale	user.attribute
e785039e-e039-4260-a927-d1daa4c63f98	true	id.token.claim
e785039e-e039-4260-a927-d1daa4c63f98	true	access.token.claim
e785039e-e039-4260-a927-d1daa4c63f98	locale	claim.name
e785039e-e039-4260-a927-d1daa4c63f98	String	jsonType.label
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	true	introspection.token.claim
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	true	userinfo.token.claim
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	emailVerified	user.attribute
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	true	id.token.claim
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	true	access.token.claim
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	email_verified	claim.name
21d539f7-3e8b-44f5-80ca-5f0a1b4e8c05	boolean	jsonType.label
b7718c3a-5e77-43dc-9419-7641b2b8355e	true	introspection.token.claim
b7718c3a-5e77-43dc-9419-7641b2b8355e	true	userinfo.token.claim
b7718c3a-5e77-43dc-9419-7641b2b8355e	email	user.attribute
b7718c3a-5e77-43dc-9419-7641b2b8355e	true	id.token.claim
b7718c3a-5e77-43dc-9419-7641b2b8355e	true	access.token.claim
b7718c3a-5e77-43dc-9419-7641b2b8355e	email	claim.name
b7718c3a-5e77-43dc-9419-7641b2b8355e	String	jsonType.label
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	formatted	user.attribute.formatted
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	country	user.attribute.country
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	true	introspection.token.claim
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	postal_code	user.attribute.postal_code
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	true	userinfo.token.claim
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	street	user.attribute.street
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	true	id.token.claim
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	region	user.attribute.region
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	true	access.token.claim
b12ecb50-8db4-4c8f-9cb7-614ce87f2dbb	locality	user.attribute.locality
3451e4ed-a933-4927-ad7a-1f9746476501	true	introspection.token.claim
3451e4ed-a933-4927-ad7a-1f9746476501	true	userinfo.token.claim
3451e4ed-a933-4927-ad7a-1f9746476501	phoneNumber	user.attribute
3451e4ed-a933-4927-ad7a-1f9746476501	true	id.token.claim
3451e4ed-a933-4927-ad7a-1f9746476501	true	access.token.claim
3451e4ed-a933-4927-ad7a-1f9746476501	phone_number	claim.name
3451e4ed-a933-4927-ad7a-1f9746476501	String	jsonType.label
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	true	introspection.token.claim
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	true	userinfo.token.claim
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	phoneNumberVerified	user.attribute
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	true	id.token.claim
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	true	access.token.claim
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	phone_number_verified	claim.name
a374efe0-5fa2-4ddf-addf-b87fb43ce1de	boolean	jsonType.label
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	true	introspection.token.claim
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	true	multivalued
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	foo	user.attribute
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	true	access.token.claim
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	resource_access.${client_id}.roles	claim.name
a6b9c21b-f6f0-4c7a-9dd5-1af215f69c3a	String	jsonType.label
c1434edd-0106-4d19-a155-7ab1d532644d	true	introspection.token.claim
c1434edd-0106-4d19-a155-7ab1d532644d	true	multivalued
c1434edd-0106-4d19-a155-7ab1d532644d	foo	user.attribute
c1434edd-0106-4d19-a155-7ab1d532644d	true	access.token.claim
c1434edd-0106-4d19-a155-7ab1d532644d	realm_access.roles	claim.name
c1434edd-0106-4d19-a155-7ab1d532644d	String	jsonType.label
dc22b363-a9b3-42e5-981b-d1ef94f55239	true	introspection.token.claim
dc22b363-a9b3-42e5-981b-d1ef94f55239	true	access.token.claim
a4ef4717-a80a-4ab2-b4ba-bcfe85470cbb	true	introspection.token.claim
a4ef4717-a80a-4ab2-b4ba-bcfe85470cbb	true	access.token.claim
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	true	introspection.token.claim
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	true	userinfo.token.claim
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	username	user.attribute
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	true	id.token.claim
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	true	access.token.claim
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	upn	claim.name
0cb49351-dc00-4dba-9c3e-9a894c7a4e76	String	jsonType.label
96fd5608-831d-4ce1-844f-2b6413fb3c76	true	introspection.token.claim
96fd5608-831d-4ce1-844f-2b6413fb3c76	true	multivalued
96fd5608-831d-4ce1-844f-2b6413fb3c76	foo	user.attribute
96fd5608-831d-4ce1-844f-2b6413fb3c76	true	id.token.claim
96fd5608-831d-4ce1-844f-2b6413fb3c76	true	access.token.claim
96fd5608-831d-4ce1-844f-2b6413fb3c76	groups	claim.name
96fd5608-831d-4ce1-844f-2b6413fb3c76	String	jsonType.label
ee1f2e56-a49c-4faf-b421-42fc2921f925	true	introspection.token.claim
ee1f2e56-a49c-4faf-b421-42fc2921f925	true	id.token.claim
ee1f2e56-a49c-4faf-b421-42fc2921f925	true	access.token.claim
86c54862-47f4-4dbc-adab-de014d4ae93b	true	introspection.token.claim
86c54862-47f4-4dbc-adab-de014d4ae93b	true	access.token.claim
fd45deca-d423-4691-9ebb-159a8db80182	AUTH_TIME	user.session.note
fd45deca-d423-4691-9ebb-159a8db80182	true	introspection.token.claim
fd45deca-d423-4691-9ebb-159a8db80182	true	id.token.claim
fd45deca-d423-4691-9ebb-159a8db80182	true	access.token.claim
fd45deca-d423-4691-9ebb-159a8db80182	auth_time	claim.name
fd45deca-d423-4691-9ebb-159a8db80182	long	jsonType.label
d7b1b9d4-4505-4593-aad5-b059218d47d5	false	single
d7b1b9d4-4505-4593-aad5-b059218d47d5	Basic	attribute.nameformat
d7b1b9d4-4505-4593-aad5-b059218d47d5	Role	attribute.name
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	true	introspection.token.claim
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	true	userinfo.token.claim
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	birthdate	user.attribute
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	true	id.token.claim
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	true	access.token.claim
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	birthdate	claim.name
137fdf6f-9b16-4f83-bacc-e3c55cb657e1	String	jsonType.label
16183585-bfb7-4e77-b648-ca47fb3165f5	true	introspection.token.claim
16183585-bfb7-4e77-b648-ca47fb3165f5	true	userinfo.token.claim
16183585-bfb7-4e77-b648-ca47fb3165f5	zoneinfo	user.attribute
16183585-bfb7-4e77-b648-ca47fb3165f5	true	id.token.claim
16183585-bfb7-4e77-b648-ca47fb3165f5	true	access.token.claim
16183585-bfb7-4e77-b648-ca47fb3165f5	zoneinfo	claim.name
16183585-bfb7-4e77-b648-ca47fb3165f5	String	jsonType.label
29c8707f-8979-4a25-bec6-890f83577012	true	introspection.token.claim
29c8707f-8979-4a25-bec6-890f83577012	true	userinfo.token.claim
29c8707f-8979-4a25-bec6-890f83577012	nickname	user.attribute
29c8707f-8979-4a25-bec6-890f83577012	true	id.token.claim
29c8707f-8979-4a25-bec6-890f83577012	true	access.token.claim
29c8707f-8979-4a25-bec6-890f83577012	nickname	claim.name
29c8707f-8979-4a25-bec6-890f83577012	String	jsonType.label
417feef3-b788-4456-9628-46dab243f848	true	introspection.token.claim
417feef3-b788-4456-9628-46dab243f848	true	userinfo.token.claim
417feef3-b788-4456-9628-46dab243f848	locale	user.attribute
417feef3-b788-4456-9628-46dab243f848	true	id.token.claim
417feef3-b788-4456-9628-46dab243f848	true	access.token.claim
417feef3-b788-4456-9628-46dab243f848	locale	claim.name
417feef3-b788-4456-9628-46dab243f848	String	jsonType.label
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	true	introspection.token.claim
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	true	userinfo.token.claim
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	middleName	user.attribute
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	true	id.token.claim
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	true	access.token.claim
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	middle_name	claim.name
55d99ac9-8d3e-4609-ba09-09ce5f71fab9	String	jsonType.label
6b3465df-0365-4237-9000-005561f21da4	true	introspection.token.claim
6b3465df-0365-4237-9000-005561f21da4	true	userinfo.token.claim
6b3465df-0365-4237-9000-005561f21da4	true	id.token.claim
6b3465df-0365-4237-9000-005561f21da4	true	access.token.claim
6ec9d846-ab7b-4b53-8b56-78f0df938b44	true	introspection.token.claim
6ec9d846-ab7b-4b53-8b56-78f0df938b44	true	userinfo.token.claim
6ec9d846-ab7b-4b53-8b56-78f0df938b44	gender	user.attribute
6ec9d846-ab7b-4b53-8b56-78f0df938b44	true	id.token.claim
6ec9d846-ab7b-4b53-8b56-78f0df938b44	true	access.token.claim
6ec9d846-ab7b-4b53-8b56-78f0df938b44	gender	claim.name
6ec9d846-ab7b-4b53-8b56-78f0df938b44	String	jsonType.label
875829c7-6c7f-429b-9273-784984235722	true	introspection.token.claim
875829c7-6c7f-429b-9273-784984235722	true	userinfo.token.claim
875829c7-6c7f-429b-9273-784984235722	profile	user.attribute
875829c7-6c7f-429b-9273-784984235722	true	id.token.claim
875829c7-6c7f-429b-9273-784984235722	true	access.token.claim
875829c7-6c7f-429b-9273-784984235722	profile	claim.name
875829c7-6c7f-429b-9273-784984235722	String	jsonType.label
a5e439f3-32a8-4d2a-8d80-7371513621d3	true	introspection.token.claim
a5e439f3-32a8-4d2a-8d80-7371513621d3	true	userinfo.token.claim
a5e439f3-32a8-4d2a-8d80-7371513621d3	lastName	user.attribute
a5e439f3-32a8-4d2a-8d80-7371513621d3	true	id.token.claim
a5e439f3-32a8-4d2a-8d80-7371513621d3	true	access.token.claim
a5e439f3-32a8-4d2a-8d80-7371513621d3	family_name	claim.name
a5e439f3-32a8-4d2a-8d80-7371513621d3	String	jsonType.label
b39476df-9072-46bb-857d-8ac3bb492b0e	true	introspection.token.claim
b39476df-9072-46bb-857d-8ac3bb492b0e	true	userinfo.token.claim
b39476df-9072-46bb-857d-8ac3bb492b0e	firstName	user.attribute
b39476df-9072-46bb-857d-8ac3bb492b0e	true	id.token.claim
b39476df-9072-46bb-857d-8ac3bb492b0e	true	access.token.claim
b39476df-9072-46bb-857d-8ac3bb492b0e	given_name	claim.name
b39476df-9072-46bb-857d-8ac3bb492b0e	String	jsonType.label
b53d1a7c-1de4-41c1-af18-34357d9e1056	true	introspection.token.claim
b53d1a7c-1de4-41c1-af18-34357d9e1056	true	userinfo.token.claim
b53d1a7c-1de4-41c1-af18-34357d9e1056	picture	user.attribute
b53d1a7c-1de4-41c1-af18-34357d9e1056	true	id.token.claim
b53d1a7c-1de4-41c1-af18-34357d9e1056	true	access.token.claim
b53d1a7c-1de4-41c1-af18-34357d9e1056	picture	claim.name
b53d1a7c-1de4-41c1-af18-34357d9e1056	String	jsonType.label
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	true	introspection.token.claim
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	true	userinfo.token.claim
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	username	user.attribute
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	true	id.token.claim
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	true	access.token.claim
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	preferred_username	claim.name
d0ba327a-2a45-4a82-83ef-e2e569be6d7d	String	jsonType.label
e04f7395-0117-4d2a-b824-b0df5d7484d8	true	introspection.token.claim
e04f7395-0117-4d2a-b824-b0df5d7484d8	true	userinfo.token.claim
e04f7395-0117-4d2a-b824-b0df5d7484d8	updatedAt	user.attribute
e04f7395-0117-4d2a-b824-b0df5d7484d8	true	id.token.claim
e04f7395-0117-4d2a-b824-b0df5d7484d8	true	access.token.claim
e04f7395-0117-4d2a-b824-b0df5d7484d8	updated_at	claim.name
e04f7395-0117-4d2a-b824-b0df5d7484d8	long	jsonType.label
f296161b-f90d-4573-af79-07a3dea3ac04	true	introspection.token.claim
f296161b-f90d-4573-af79-07a3dea3ac04	true	userinfo.token.claim
f296161b-f90d-4573-af79-07a3dea3ac04	website	user.attribute
f296161b-f90d-4573-af79-07a3dea3ac04	true	id.token.claim
f296161b-f90d-4573-af79-07a3dea3ac04	true	access.token.claim
f296161b-f90d-4573-af79-07a3dea3ac04	website	claim.name
f296161b-f90d-4573-af79-07a3dea3ac04	String	jsonType.label
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	true	introspection.token.claim
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	true	userinfo.token.claim
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	emailVerified	user.attribute
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	true	id.token.claim
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	true	access.token.claim
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	email_verified	claim.name
12cf8443-07ab-45bf-9dcf-0ccfb5e0c1fa	boolean	jsonType.label
19afa6dd-1430-430e-8421-4b5bd5ec0909	true	introspection.token.claim
19afa6dd-1430-430e-8421-4b5bd5ec0909	true	userinfo.token.claim
19afa6dd-1430-430e-8421-4b5bd5ec0909	email	user.attribute
19afa6dd-1430-430e-8421-4b5bd5ec0909	true	id.token.claim
19afa6dd-1430-430e-8421-4b5bd5ec0909	true	access.token.claim
19afa6dd-1430-430e-8421-4b5bd5ec0909	email	claim.name
19afa6dd-1430-430e-8421-4b5bd5ec0909	String	jsonType.label
70977daa-8cbe-450a-9545-e9e16d0e06ad	formatted	user.attribute.formatted
70977daa-8cbe-450a-9545-e9e16d0e06ad	country	user.attribute.country
70977daa-8cbe-450a-9545-e9e16d0e06ad	true	introspection.token.claim
70977daa-8cbe-450a-9545-e9e16d0e06ad	postal_code	user.attribute.postal_code
70977daa-8cbe-450a-9545-e9e16d0e06ad	true	userinfo.token.claim
70977daa-8cbe-450a-9545-e9e16d0e06ad	street	user.attribute.street
70977daa-8cbe-450a-9545-e9e16d0e06ad	true	id.token.claim
70977daa-8cbe-450a-9545-e9e16d0e06ad	region	user.attribute.region
70977daa-8cbe-450a-9545-e9e16d0e06ad	true	access.token.claim
70977daa-8cbe-450a-9545-e9e16d0e06ad	locality	user.attribute.locality
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	true	introspection.token.claim
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	true	userinfo.token.claim
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	phoneNumberVerified	user.attribute
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	true	id.token.claim
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	true	access.token.claim
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	phone_number_verified	claim.name
2ec5d02b-765b-414f-84d4-8e2f69f7de3c	boolean	jsonType.label
ca4c33bd-b107-4a99-a672-baf6edc03a11	true	introspection.token.claim
ca4c33bd-b107-4a99-a672-baf6edc03a11	true	userinfo.token.claim
ca4c33bd-b107-4a99-a672-baf6edc03a11	phoneNumber	user.attribute
ca4c33bd-b107-4a99-a672-baf6edc03a11	true	id.token.claim
ca4c33bd-b107-4a99-a672-baf6edc03a11	true	access.token.claim
ca4c33bd-b107-4a99-a672-baf6edc03a11	phone_number	claim.name
ca4c33bd-b107-4a99-a672-baf6edc03a11	String	jsonType.label
08c820de-4414-4909-93e3-640f67935962	true	introspection.token.claim
08c820de-4414-4909-93e3-640f67935962	true	access.token.claim
3c635780-a462-4b50-ac10-aeb9cd34b4ee	true	introspection.token.claim
3c635780-a462-4b50-ac10-aeb9cd34b4ee	true	multivalued
3c635780-a462-4b50-ac10-aeb9cd34b4ee	foo	user.attribute
3c635780-a462-4b50-ac10-aeb9cd34b4ee	true	access.token.claim
3c635780-a462-4b50-ac10-aeb9cd34b4ee	realm_access.roles	claim.name
3c635780-a462-4b50-ac10-aeb9cd34b4ee	String	jsonType.label
7a162631-5017-4f77-a05b-727aeee7bf6a	true	introspection.token.claim
7a162631-5017-4f77-a05b-727aeee7bf6a	true	multivalued
7a162631-5017-4f77-a05b-727aeee7bf6a	foo	user.attribute
7a162631-5017-4f77-a05b-727aeee7bf6a	true	access.token.claim
7a162631-5017-4f77-a05b-727aeee7bf6a	resource_access.${client_id}.roles	claim.name
7a162631-5017-4f77-a05b-727aeee7bf6a	String	jsonType.label
9fa5cebd-f89d-4cc2-8938-c68174b67630	true	introspection.token.claim
9fa5cebd-f89d-4cc2-8938-c68174b67630	true	access.token.claim
7454eb51-6055-4a11-89b7-ac5e22f76545	true	introspection.token.claim
7454eb51-6055-4a11-89b7-ac5e22f76545	true	multivalued
7454eb51-6055-4a11-89b7-ac5e22f76545	foo	user.attribute
7454eb51-6055-4a11-89b7-ac5e22f76545	true	id.token.claim
7454eb51-6055-4a11-89b7-ac5e22f76545	true	access.token.claim
7454eb51-6055-4a11-89b7-ac5e22f76545	groups	claim.name
7454eb51-6055-4a11-89b7-ac5e22f76545	String	jsonType.label
9495243a-0ebc-4909-8522-9429bd09988c	true	introspection.token.claim
9495243a-0ebc-4909-8522-9429bd09988c	true	userinfo.token.claim
9495243a-0ebc-4909-8522-9429bd09988c	username	user.attribute
9495243a-0ebc-4909-8522-9429bd09988c	true	id.token.claim
9495243a-0ebc-4909-8522-9429bd09988c	true	access.token.claim
9495243a-0ebc-4909-8522-9429bd09988c	upn	claim.name
9495243a-0ebc-4909-8522-9429bd09988c	String	jsonType.label
ff46743a-5448-4960-b8b4-e3213b5abd2e	true	introspection.token.claim
ff46743a-5448-4960-b8b4-e3213b5abd2e	true	id.token.claim
ff46743a-5448-4960-b8b4-e3213b5abd2e	true	access.token.claim
76d0813b-4779-4a55-8fee-8b605ccf47e3	true	introspection.token.claim
76d0813b-4779-4a55-8fee-8b605ccf47e3	true	access.token.claim
e68751b0-44b9-4d8a-82b3-7d6911188be2	AUTH_TIME	user.session.note
e68751b0-44b9-4d8a-82b3-7d6911188be2	true	introspection.token.claim
e68751b0-44b9-4d8a-82b3-7d6911188be2	true	id.token.claim
e68751b0-44b9-4d8a-82b3-7d6911188be2	true	access.token.claim
e68751b0-44b9-4d8a-82b3-7d6911188be2	auth_time	claim.name
e68751b0-44b9-4d8a-82b3-7d6911188be2	long	jsonType.label
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	true	introspection.token.claim
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	true	userinfo.token.claim
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	locale	user.attribute
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	true	id.token.claim
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	true	access.token.claim
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	locale	claim.name
9f1f4a31-9d93-4e17-86d4-40dfc1dad5d2	String	jsonType.label
47140054-0d62-433b-a95a-87cdf7b888cc	client_id	user.session.note
47140054-0d62-433b-a95a-87cdf7b888cc	true	introspection.token.claim
47140054-0d62-433b-a95a-87cdf7b888cc	true	id.token.claim
47140054-0d62-433b-a95a-87cdf7b888cc	true	access.token.claim
47140054-0d62-433b-a95a-87cdf7b888cc	client_id	claim.name
47140054-0d62-433b-a95a-87cdf7b888cc	String	jsonType.label
55195dc4-5cb3-4ae1-aefe-59e97183734f	clientAddress	user.session.note
55195dc4-5cb3-4ae1-aefe-59e97183734f	true	introspection.token.claim
55195dc4-5cb3-4ae1-aefe-59e97183734f	true	id.token.claim
55195dc4-5cb3-4ae1-aefe-59e97183734f	true	access.token.claim
55195dc4-5cb3-4ae1-aefe-59e97183734f	clientAddress	claim.name
55195dc4-5cb3-4ae1-aefe-59e97183734f	String	jsonType.label
82bd1d42-0986-4df7-ade2-212d393191a0	clientHost	user.session.note
82bd1d42-0986-4df7-ade2-212d393191a0	true	introspection.token.claim
82bd1d42-0986-4df7-ade2-212d393191a0	true	id.token.claim
82bd1d42-0986-4df7-ade2-212d393191a0	true	access.token.claim
82bd1d42-0986-4df7-ade2-212d393191a0	clientHost	claim.name
82bd1d42-0986-4df7-ade2-212d393191a0	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
2eca1426-cce8-48c4-a944-90aa859476ff	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6d49f9d7-5c39-403e-8651-b349982997c6	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d8ca3361-b58a-4b80-a876-b11c4e4872bd	baa452eb-29d8-450a-b70f-534a841d5fc4	b2c5494e-eb3b-4976-a1cf-d43e4c425a82	8fdcf4b6-0a70-4199-9f82-2669f2ad4a6e	85038df2-2b44-48c4-a975-ee9fa62be024	2592000	f	900	t	f	40087af9-532e-4861-86ac-e88abda1bc6c	0	f	0	0	9491f30d-f8f4-42c8-9581-d918f4ca9149
00164430-588c-4b7e-a550-cedd315756a4	60	300	300	\N	\N	\N	t	f	0	\N	apache-realm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	3e84fc6e-f844-432d-b205-1bd1b8255474	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	4df42a5a-44c6-4ad7-8a5a-9ff90e47d850	4e1c229f-b8e4-4bc1-a620-92961a47b0da	4aa8d267-6540-4d79-8269-462c2f3a9edc	202006e2-9717-44b9-8368-3aa0e29df77b	8faaf973-b6d8-4bbd-a766-02f9a3903fc6	2592000	f	900	t	f	bc848b48-96ae-4a0a-92b9-07c3f02b9f11	0	f	0	0	2e66ac80-d139-4244-b0d3-757c649a4fe3
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	2eca1426-cce8-48c4-a944-90aa859476ff	
_browser_header.xContentTypeOptions	2eca1426-cce8-48c4-a944-90aa859476ff	nosniff
_browser_header.referrerPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	no-referrer
_browser_header.xRobotsTag	2eca1426-cce8-48c4-a944-90aa859476ff	none
_browser_header.xFrameOptions	2eca1426-cce8-48c4-a944-90aa859476ff	SAMEORIGIN
_browser_header.contentSecurityPolicy	2eca1426-cce8-48c4-a944-90aa859476ff	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	2eca1426-cce8-48c4-a944-90aa859476ff	1; mode=block
_browser_header.strictTransportSecurity	2eca1426-cce8-48c4-a944-90aa859476ff	max-age=31536000; includeSubDomains
bruteForceProtected	2eca1426-cce8-48c4-a944-90aa859476ff	false
permanentLockout	2eca1426-cce8-48c4-a944-90aa859476ff	false
maxTemporaryLockouts	2eca1426-cce8-48c4-a944-90aa859476ff	0
maxFailureWaitSeconds	2eca1426-cce8-48c4-a944-90aa859476ff	900
minimumQuickLoginWaitSeconds	2eca1426-cce8-48c4-a944-90aa859476ff	60
waitIncrementSeconds	2eca1426-cce8-48c4-a944-90aa859476ff	60
quickLoginCheckMilliSeconds	2eca1426-cce8-48c4-a944-90aa859476ff	1000
maxDeltaTimeSeconds	2eca1426-cce8-48c4-a944-90aa859476ff	43200
failureFactor	2eca1426-cce8-48c4-a944-90aa859476ff	30
realmReusableOtpCode	2eca1426-cce8-48c4-a944-90aa859476ff	false
firstBrokerLoginFlowId	2eca1426-cce8-48c4-a944-90aa859476ff	9b45498c-8f3e-4dda-8914-bcad5046b6a5
displayName	2eca1426-cce8-48c4-a944-90aa859476ff	Keycloak
displayNameHtml	2eca1426-cce8-48c4-a944-90aa859476ff	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	2eca1426-cce8-48c4-a944-90aa859476ff	RS256
offlineSessionMaxLifespanEnabled	2eca1426-cce8-48c4-a944-90aa859476ff	false
offlineSessionMaxLifespan	2eca1426-cce8-48c4-a944-90aa859476ff	5184000
bruteForceProtected	00164430-588c-4b7e-a550-cedd315756a4	false
permanentLockout	00164430-588c-4b7e-a550-cedd315756a4	false
maxTemporaryLockouts	00164430-588c-4b7e-a550-cedd315756a4	0
maxFailureWaitSeconds	00164430-588c-4b7e-a550-cedd315756a4	900
minimumQuickLoginWaitSeconds	00164430-588c-4b7e-a550-cedd315756a4	60
waitIncrementSeconds	00164430-588c-4b7e-a550-cedd315756a4	60
quickLoginCheckMilliSeconds	00164430-588c-4b7e-a550-cedd315756a4	1000
maxDeltaTimeSeconds	00164430-588c-4b7e-a550-cedd315756a4	43200
failureFactor	00164430-588c-4b7e-a550-cedd315756a4	30
realmReusableOtpCode	00164430-588c-4b7e-a550-cedd315756a4	false
defaultSignatureAlgorithm	00164430-588c-4b7e-a550-cedd315756a4	RS256
offlineSessionMaxLifespanEnabled	00164430-588c-4b7e-a550-cedd315756a4	false
offlineSessionMaxLifespan	00164430-588c-4b7e-a550-cedd315756a4	5184000
actionTokenGeneratedByAdminLifespan	00164430-588c-4b7e-a550-cedd315756a4	43200
actionTokenGeneratedByUserLifespan	00164430-588c-4b7e-a550-cedd315756a4	300
oauth2DeviceCodeLifespan	00164430-588c-4b7e-a550-cedd315756a4	600
oauth2DevicePollingInterval	00164430-588c-4b7e-a550-cedd315756a4	5
webAuthnPolicyRpEntityName	00164430-588c-4b7e-a550-cedd315756a4	keycloak
webAuthnPolicySignatureAlgorithms	00164430-588c-4b7e-a550-cedd315756a4	ES256
webAuthnPolicyRpId	00164430-588c-4b7e-a550-cedd315756a4	
webAuthnPolicyAttestationConveyancePreference	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyAuthenticatorAttachment	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyRequireResidentKey	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyUserVerificationRequirement	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyCreateTimeout	00164430-588c-4b7e-a550-cedd315756a4	0
webAuthnPolicyAvoidSameAuthenticatorRegister	00164430-588c-4b7e-a550-cedd315756a4	false
webAuthnPolicyRpEntityNamePasswordless	00164430-588c-4b7e-a550-cedd315756a4	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	00164430-588c-4b7e-a550-cedd315756a4	ES256
webAuthnPolicyRpIdPasswordless	00164430-588c-4b7e-a550-cedd315756a4	
webAuthnPolicyAttestationConveyancePreferencePasswordless	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyRequireResidentKeyPasswordless	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	00164430-588c-4b7e-a550-cedd315756a4	not specified
webAuthnPolicyCreateTimeoutPasswordless	00164430-588c-4b7e-a550-cedd315756a4	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	00164430-588c-4b7e-a550-cedd315756a4	false
cibaBackchannelTokenDeliveryMode	00164430-588c-4b7e-a550-cedd315756a4	poll
cibaExpiresIn	00164430-588c-4b7e-a550-cedd315756a4	120
cibaInterval	00164430-588c-4b7e-a550-cedd315756a4	5
cibaAuthRequestedUserHint	00164430-588c-4b7e-a550-cedd315756a4	login_hint
parRequestUriLifespan	00164430-588c-4b7e-a550-cedd315756a4	60
firstBrokerLoginFlowId	00164430-588c-4b7e-a550-cedd315756a4	fc6f9e4e-b244-416f-ac2c-ffd1400acf4b
acr.loa.map	00164430-588c-4b7e-a550-cedd315756a4	{}
frontendUrl	00164430-588c-4b7e-a550-cedd315756a4	
displayName	00164430-588c-4b7e-a550-cedd315756a4	
displayNameHtml	00164430-588c-4b7e-a550-cedd315756a4	
organizationsEnabled	00164430-588c-4b7e-a550-cedd315756a4	false
clientSessionIdleTimeout	00164430-588c-4b7e-a550-cedd315756a4	0
clientSessionMaxLifespan	00164430-588c-4b7e-a550-cedd315756a4	0
clientOfflineSessionIdleTimeout	00164430-588c-4b7e-a550-cedd315756a4	0
clientOfflineSessionMaxLifespan	00164430-588c-4b7e-a550-cedd315756a4	0
client-policies.profiles	00164430-588c-4b7e-a550-cedd315756a4	{"profiles":[]}
client-policies.policies	00164430-588c-4b7e-a550-cedd315756a4	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	00164430-588c-4b7e-a550-cedd315756a4	
_browser_header.xContentTypeOptions	00164430-588c-4b7e-a550-cedd315756a4	nosniff
_browser_header.referrerPolicy	00164430-588c-4b7e-a550-cedd315756a4	no-referrer
_browser_header.xRobotsTag	00164430-588c-4b7e-a550-cedd315756a4	none
_browser_header.xFrameOptions	00164430-588c-4b7e-a550-cedd315756a4	SAMEORIGIN
_browser_header.contentSecurityPolicy	00164430-588c-4b7e-a550-cedd315756a4	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	00164430-588c-4b7e-a550-cedd315756a4	1; mode=block
_browser_header.strictTransportSecurity	00164430-588c-4b7e-a550-cedd315756a4	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
2eca1426-cce8-48c4-a944-90aa859476ff	jboss-logging
00164430-588c-4b7e-a550-cedd315756a4	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	2eca1426-cce8-48c4-a944-90aa859476ff
password	password	t	t	00164430-588c-4b7e-a550-cedd315756a4
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
c1e8118b-364d-422d-93f6-03d6e6ef9feb	/realms/master/account/*
d4b85b39-6674-433d-844b-6a8d39d8ecce	/realms/master/account/*
83d065c1-c30e-4b10-8e1d-399a201d4805	/admin/master/console/*
d2900d29-9eee-4985-b398-9b1d9908b742	/realms/apache-realm/account/*
6eed25a6-533d-42d1-a2b7-385062550518	/realms/apache-realm/account/*
33a02fbc-ce94-41de-bea8-afedd6f6b780	/admin/apache-realm/console/*
305eeea6-c469-4d38-a79b-df23ef9f25da	https://x.devgains.com/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
ff905928-10b5-4d2b-a514-49260855213f	VERIFY_EMAIL	Verify Email	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	VERIFY_EMAIL	50
8a52f254-0ee8-44d6-afc2-bd74c840242b	UPDATE_PROFILE	Update Profile	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	UPDATE_PROFILE	40
f05a2659-5a8f-46b8-8186-a7cf6c37b037	CONFIGURE_TOTP	Configure OTP	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	CONFIGURE_TOTP	10
27b8baf3-c0b3-402d-9917-4adc54245037	UPDATE_PASSWORD	Update Password	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	UPDATE_PASSWORD	30
8fed06b5-9ff0-4a9c-a862-96d17c79aa38	TERMS_AND_CONDITIONS	Terms and Conditions	2eca1426-cce8-48c4-a944-90aa859476ff	f	f	TERMS_AND_CONDITIONS	20
ccb9eff5-5333-4c59-9fb6-307759aa4893	delete_account	Delete Account	2eca1426-cce8-48c4-a944-90aa859476ff	f	f	delete_account	60
6f524c8d-0eae-4738-b627-e01b2ea77ae8	delete_credential	Delete Credential	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	delete_credential	100
60d6c28c-03ca-49f7-b39a-0aeb35cd10b8	update_user_locale	Update User Locale	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	update_user_locale	1000
0f9c5a07-d507-4e56-9d1b-bb252f330709	webauthn-register	Webauthn Register	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	webauthn-register	70
07a1147d-7758-4e1a-9ad1-de1f2d5cff8e	webauthn-register-passwordless	Webauthn Register Passwordless	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	webauthn-register-passwordless	80
9047fd8c-6e3a-49ed-8f29-eb839c85adb8	VERIFY_PROFILE	Verify Profile	2eca1426-cce8-48c4-a944-90aa859476ff	t	f	VERIFY_PROFILE	90
0a2f40ef-fc1c-4ccc-8a3e-fe6812c1f750	VERIFY_EMAIL	Verify Email	00164430-588c-4b7e-a550-cedd315756a4	t	f	VERIFY_EMAIL	50
21f05356-fbe6-4fde-aad9-8e3980249ecf	UPDATE_PROFILE	Update Profile	00164430-588c-4b7e-a550-cedd315756a4	t	f	UPDATE_PROFILE	40
87d1aa53-3546-4a30-9671-cc8de382cf6c	CONFIGURE_TOTP	Configure OTP	00164430-588c-4b7e-a550-cedd315756a4	t	f	CONFIGURE_TOTP	10
b246f219-62f4-45cf-9254-e95476a661a2	UPDATE_PASSWORD	Update Password	00164430-588c-4b7e-a550-cedd315756a4	t	f	UPDATE_PASSWORD	30
9f69df6e-ba0f-4610-97cc-2af9ef2a6494	TERMS_AND_CONDITIONS	Terms and Conditions	00164430-588c-4b7e-a550-cedd315756a4	f	f	TERMS_AND_CONDITIONS	20
792ad2a9-20f0-4a55-85b5-33c8180b8275	delete_account	Delete Account	00164430-588c-4b7e-a550-cedd315756a4	f	f	delete_account	60
77bbfdab-d22c-4119-a3a0-092fd17320fa	delete_credential	Delete Credential	00164430-588c-4b7e-a550-cedd315756a4	t	f	delete_credential	100
e31b43e5-91f3-468f-b67f-d2c3ddb3939d	update_user_locale	Update User Locale	00164430-588c-4b7e-a550-cedd315756a4	t	f	update_user_locale	1000
bbde4790-2b8d-4925-89d6-86d46836a76c	webauthn-register	Webauthn Register	00164430-588c-4b7e-a550-cedd315756a4	t	f	webauthn-register	70
bfcbbb26-68cc-4c19-9ed8-2c484724b4c6	webauthn-register-passwordless	Webauthn Register Passwordless	00164430-588c-4b7e-a550-cedd315756a4	t	f	webauthn-register-passwordless	80
b74660e4-c4f4-4a99-9d8e-aa2d218bfd9c	VERIFY_PROFILE	Verify Profile	00164430-588c-4b7e-a550-cedd315756a4	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
305eeea6-c469-4d38-a79b-df23ef9f25da	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
aa9e7b0e-f4a7-4e0d-a3dd-8c5c75ce8bf1	Default Policy	A policy that grants access only for users within this realm	js	0	0	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
df17ed78-2177-4bb0-8115-8753b10e25b3	Default Permission	A permission that applies to the default resource type	resource	1	0	305eeea6-c469-4d38-a79b-df23ef9f25da	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
7d6d2754-4987-4346-bb2c-09f4132512ff	Default Resource	urn:apache:resources:default	\N	305eeea6-c469-4d38-a79b-df23ef9f25da	305eeea6-c469-4d38-a79b-df23ef9f25da	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
7d6d2754-4987-4346-bb2c-09f4132512ff	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d4b85b39-6674-433d-844b-6a8d39d8ecce	073c555d-87bf-4edf-b681-f368d7134717
d4b85b39-6674-433d-844b-6a8d39d8ecce	a1701b2b-b554-4ca8-857b-267be6442e03
6eed25a6-533d-42d1-a2b7-385062550518	efd25779-b7d7-4026-ba40-d51d69bdfe03
6eed25a6-533d-42d1-a2b7-385062550518	280b4873-eb65-430c-97ee-99f91a06b0d9
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
02ebcdd8-7697-4a8b-bbd5-124359173db0	\N	119ec76c-729c-4397-959d-676e69f67ec0	f	t	\N	\N	\N	2eca1426-cce8-48c4-a944-90aa859476ff	admin	1720094409119	\N	0
9f1502b9-3dc8-4feb-9af1-7e6d2ecbb203	epita@epita.fr	epita@epita.fr	f	t	\N	epita	epita	00164430-588c-4b7e-a550-cedd315756a4	epita	1720096789634	\N	0
5ae041f7-2eef-4752-87f3-1b93e8e5b594	\N	f9e866bc-8642-4979-ae8a-3f960b12c2ae	f	t	\N	\N	\N	00164430-588c-4b7e-a550-cedd315756a4	service-account-apache	1720290767793	305eeea6-c469-4d38-a79b-df23ef9f25da	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
9491f30d-f8f4-42c8-9581-d918f4ca9149	02ebcdd8-7697-4a8b-bbd5-124359173db0
5a35b367-e0c1-488d-ba7e-4a9617cf6de2	02ebcdd8-7697-4a8b-bbd5-124359173db0
42568722-9506-4ddf-911b-7ee82b465992	02ebcdd8-7697-4a8b-bbd5-124359173db0
ed34c10d-036b-457a-86d2-16690329d20e	02ebcdd8-7697-4a8b-bbd5-124359173db0
02dc0e33-c4ba-4ed1-934a-45643850fc83	02ebcdd8-7697-4a8b-bbd5-124359173db0
c8ea3c2d-7ca7-4cd4-8c8d-3b1d349da1c6	02ebcdd8-7697-4a8b-bbd5-124359173db0
444ab0a2-07fb-49b1-b701-fbc4dbc6a371	02ebcdd8-7697-4a8b-bbd5-124359173db0
1c05a0ea-9895-400f-8dfb-cbc15aa80aa4	02ebcdd8-7697-4a8b-bbd5-124359173db0
5d3a2aa3-3bc3-43df-b650-1b23982900d9	02ebcdd8-7697-4a8b-bbd5-124359173db0
f6895c18-35c6-4059-a03f-126f6d7ac1c9	02ebcdd8-7697-4a8b-bbd5-124359173db0
a1f8fbda-1c36-4e4b-aa35-394b4ebe975b	02ebcdd8-7697-4a8b-bbd5-124359173db0
70bbf378-9e63-4cf5-8450-07e5721a0dd5	02ebcdd8-7697-4a8b-bbd5-124359173db0
3688fa0d-4bf0-43d2-894e-fad1775fea84	02ebcdd8-7697-4a8b-bbd5-124359173db0
014bc0aa-1536-404f-81d7-649758323b83	02ebcdd8-7697-4a8b-bbd5-124359173db0
6007177d-285a-4b0b-a314-191166f2ce9e	02ebcdd8-7697-4a8b-bbd5-124359173db0
af8b109f-e1ed-4229-a434-a278529f8d30	02ebcdd8-7697-4a8b-bbd5-124359173db0
29a07df8-47f9-4706-886c-d93e66da39bc	02ebcdd8-7697-4a8b-bbd5-124359173db0
94b0bed5-35d4-4ac3-90fb-afe2322a1a68	02ebcdd8-7697-4a8b-bbd5-124359173db0
9ca077bb-8616-4e30-9a01-2547e2e5b5f6	02ebcdd8-7697-4a8b-bbd5-124359173db0
2e66ac80-d139-4244-b0d3-757c649a4fe3	9f1502b9-3dc8-4feb-9af1-7e6d2ecbb203
2e66ac80-d139-4244-b0d3-757c649a4fe3	5ae041f7-2eef-4752-87f3-1b93e8e5b594
a1a0f7e6-ca57-48d9-ab0e-cc08aa9a7084	5ae041f7-2eef-4752-87f3-1b93e8e5b594
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
83d065c1-c30e-4b10-8e1d-399a201d4805	+
33a02fbc-ce94-41de-bea8-afedd6f6b780	+
305eeea6-c469-4d38-a79b-df23ef9f25da	+
305eeea6-c469-4d38-a79b-df23ef9f25da	/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

