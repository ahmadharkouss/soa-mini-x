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
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
92ad1a44-dfd7-440d-a5b7-a3c0f8d24a7d	\N	auth-cookie	679c1e80-fcc8-4163-ae01-167899dcf2c9	16d4af84-2400-4742-968e-c80eba53c158	2	10	f	\N	\N
d88b1b87-3ea9-44b1-8364-e06da3506493	\N	auth-spnego	679c1e80-fcc8-4163-ae01-167899dcf2c9	16d4af84-2400-4742-968e-c80eba53c158	3	20	f	\N	\N
087ca22f-1f35-4585-b142-f3d3c92895d9	\N	identity-provider-redirector	679c1e80-fcc8-4163-ae01-167899dcf2c9	16d4af84-2400-4742-968e-c80eba53c158	2	25	f	\N	\N
51004628-7511-4f18-8093-b1207a1ba3d8	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	16d4af84-2400-4742-968e-c80eba53c158	2	30	t	c7116fe3-2764-4efd-b6a5-ddc8bd314b47	\N
75ea6276-b85a-4ba8-a881-c128a4a5d9c2	\N	auth-username-password-form	679c1e80-fcc8-4163-ae01-167899dcf2c9	c7116fe3-2764-4efd-b6a5-ddc8bd314b47	0	10	f	\N	\N
1054524d-ac7e-4491-b557-51ef2bcc8cfa	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	c7116fe3-2764-4efd-b6a5-ddc8bd314b47	1	20	t	df2a9e0f-3435-4748-af6b-fbfae1c21838	\N
2a4e7794-0cde-478e-bf25-22645602db6c	\N	conditional-user-configured	679c1e80-fcc8-4163-ae01-167899dcf2c9	df2a9e0f-3435-4748-af6b-fbfae1c21838	0	10	f	\N	\N
0d7a762a-c65f-431b-89c5-d4ba918b2a8d	\N	auth-otp-form	679c1e80-fcc8-4163-ae01-167899dcf2c9	df2a9e0f-3435-4748-af6b-fbfae1c21838	0	20	f	\N	\N
8ec22f60-80b2-4400-bbee-11a7d24d5fbc	\N	direct-grant-validate-username	679c1e80-fcc8-4163-ae01-167899dcf2c9	7eaf02e9-a8f8-4fb6-9e0d-55b857e13229	0	10	f	\N	\N
394b5ccb-b28d-4af9-b617-e42b1521f8de	\N	direct-grant-validate-password	679c1e80-fcc8-4163-ae01-167899dcf2c9	7eaf02e9-a8f8-4fb6-9e0d-55b857e13229	0	20	f	\N	\N
f2091eb6-0453-4331-9fbd-edac4dc7e1f0	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	7eaf02e9-a8f8-4fb6-9e0d-55b857e13229	1	30	t	546673c3-c163-493a-908e-bb6b2f348274	\N
49a44fc5-197f-43fe-9634-7381c552e6b8	\N	conditional-user-configured	679c1e80-fcc8-4163-ae01-167899dcf2c9	546673c3-c163-493a-908e-bb6b2f348274	0	10	f	\N	\N
1697198a-f8c8-4618-9e5f-23c0bb7cdd88	\N	direct-grant-validate-otp	679c1e80-fcc8-4163-ae01-167899dcf2c9	546673c3-c163-493a-908e-bb6b2f348274	0	20	f	\N	\N
cebf44ce-36f7-4cfd-bfad-395629d2d4aa	\N	registration-page-form	679c1e80-fcc8-4163-ae01-167899dcf2c9	ce30e49c-087b-4dc7-95cf-9f88207cfd7c	0	10	t	302f868d-d6dc-4687-8e76-413b3343d6d4	\N
e05774cb-773a-430e-b0fd-406113be208e	\N	registration-user-creation	679c1e80-fcc8-4163-ae01-167899dcf2c9	302f868d-d6dc-4687-8e76-413b3343d6d4	0	20	f	\N	\N
67fd5308-17b3-4af9-9926-53a9128be5e2	\N	registration-password-action	679c1e80-fcc8-4163-ae01-167899dcf2c9	302f868d-d6dc-4687-8e76-413b3343d6d4	0	50	f	\N	\N
46555887-61f7-4565-8f14-80d2023faaa3	\N	registration-recaptcha-action	679c1e80-fcc8-4163-ae01-167899dcf2c9	302f868d-d6dc-4687-8e76-413b3343d6d4	3	60	f	\N	\N
18fd7ba4-6914-4c2c-b0d7-bac264bf19f7	\N	registration-terms-and-conditions	679c1e80-fcc8-4163-ae01-167899dcf2c9	302f868d-d6dc-4687-8e76-413b3343d6d4	3	70	f	\N	\N
b1a81315-f898-411c-a63b-c1f96a110324	\N	reset-credentials-choose-user	679c1e80-fcc8-4163-ae01-167899dcf2c9	ed15735d-45d3-4381-9de8-fc1820426100	0	10	f	\N	\N
d7b7d130-842f-4098-90ce-13a9c0a2ce99	\N	reset-credential-email	679c1e80-fcc8-4163-ae01-167899dcf2c9	ed15735d-45d3-4381-9de8-fc1820426100	0	20	f	\N	\N
9b9499fc-25d8-42e0-b21f-1e80c0b843ff	\N	reset-password	679c1e80-fcc8-4163-ae01-167899dcf2c9	ed15735d-45d3-4381-9de8-fc1820426100	0	30	f	\N	\N
e5ae3a05-7d7d-45d7-a443-4862e8d379fd	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	ed15735d-45d3-4381-9de8-fc1820426100	1	40	t	0ed6f8fc-e24d-426a-ac0a-8c406b7ff68c	\N
d313c16a-527e-4f5c-b29f-bc6f4e503ebf	\N	conditional-user-configured	679c1e80-fcc8-4163-ae01-167899dcf2c9	0ed6f8fc-e24d-426a-ac0a-8c406b7ff68c	0	10	f	\N	\N
2eea1e65-93da-4973-8140-612240c4f1f0	\N	reset-otp	679c1e80-fcc8-4163-ae01-167899dcf2c9	0ed6f8fc-e24d-426a-ac0a-8c406b7ff68c	0	20	f	\N	\N
a31907df-7a7d-4203-8c67-80584c9686b8	\N	client-secret	679c1e80-fcc8-4163-ae01-167899dcf2c9	38ddc41b-f882-4fdb-9f06-1a6e191d7987	2	10	f	\N	\N
5dc9f048-fbf2-4622-acbe-16de1ce99e15	\N	client-jwt	679c1e80-fcc8-4163-ae01-167899dcf2c9	38ddc41b-f882-4fdb-9f06-1a6e191d7987	2	20	f	\N	\N
be9bae13-5f92-4c1c-a034-3827f2e1ec16	\N	client-secret-jwt	679c1e80-fcc8-4163-ae01-167899dcf2c9	38ddc41b-f882-4fdb-9f06-1a6e191d7987	2	30	f	\N	\N
4d16d84a-723f-448e-9635-c930c9247a85	\N	client-x509	679c1e80-fcc8-4163-ae01-167899dcf2c9	38ddc41b-f882-4fdb-9f06-1a6e191d7987	2	40	f	\N	\N
f88266ce-f6d6-4cf6-bbac-cfd4e8dd902d	\N	idp-review-profile	679c1e80-fcc8-4163-ae01-167899dcf2c9	0eb63bf7-69a0-498d-9822-3558f0ef30cc	0	10	f	\N	6ecd54d8-2691-47f7-b69e-e466b572ff78
3e12c0eb-4c2c-41e9-88e8-723dc8089ab4	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	0eb63bf7-69a0-498d-9822-3558f0ef30cc	0	20	t	9f7cb60c-a419-4354-94b4-69607edd2862	\N
10951644-bab5-409c-b098-73aef3c9b64b	\N	idp-create-user-if-unique	679c1e80-fcc8-4163-ae01-167899dcf2c9	9f7cb60c-a419-4354-94b4-69607edd2862	2	10	f	\N	0cd81dd7-8111-4508-ac3e-2762357c7358
04d2d643-4985-4e14-a941-82111fbb4a3c	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	9f7cb60c-a419-4354-94b4-69607edd2862	2	20	t	6e6d538b-5b84-4a65-9b8f-b62fcb5551b8	\N
559f22dc-06a8-4a44-a248-99c94bb36d87	\N	idp-confirm-link	679c1e80-fcc8-4163-ae01-167899dcf2c9	6e6d538b-5b84-4a65-9b8f-b62fcb5551b8	0	10	f	\N	\N
bd39c8e7-f26b-466e-a03f-3c8b62657fcf	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	6e6d538b-5b84-4a65-9b8f-b62fcb5551b8	0	20	t	5243f6c4-575a-46bb-853d-cfae3d28ceec	\N
afbd800b-dad7-4dce-9b96-a3b78665e1c7	\N	idp-email-verification	679c1e80-fcc8-4163-ae01-167899dcf2c9	5243f6c4-575a-46bb-853d-cfae3d28ceec	2	10	f	\N	\N
a70d4afa-7b81-4613-8c85-8e27a7a8a6ff	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	5243f6c4-575a-46bb-853d-cfae3d28ceec	2	20	t	accd7239-e852-4e34-af1c-8e6aff5c79ce	\N
ba7c68a1-a530-49b8-903c-0e2d6de3dfa8	\N	idp-username-password-form	679c1e80-fcc8-4163-ae01-167899dcf2c9	accd7239-e852-4e34-af1c-8e6aff5c79ce	0	10	f	\N	\N
ed107cbb-d70f-4e29-9015-299a710ca6be	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	accd7239-e852-4e34-af1c-8e6aff5c79ce	1	20	t	fd0a20ee-181b-4290-931a-2bcc05cf9dcc	\N
509aad5d-7977-431c-8405-00fe8f20984a	\N	conditional-user-configured	679c1e80-fcc8-4163-ae01-167899dcf2c9	fd0a20ee-181b-4290-931a-2bcc05cf9dcc	0	10	f	\N	\N
846cb00c-9e7f-4dc6-a154-cc71cfcd79a3	\N	auth-otp-form	679c1e80-fcc8-4163-ae01-167899dcf2c9	fd0a20ee-181b-4290-931a-2bcc05cf9dcc	0	20	f	\N	\N
1b1d187e-2ad8-4fc8-8fff-3d2203682740	\N	http-basic-authenticator	679c1e80-fcc8-4163-ae01-167899dcf2c9	0947a44f-0d5a-4692-a0cb-4244707cc45d	0	10	f	\N	\N
8edebba3-a16d-487f-891c-805949f129a7	\N	docker-http-basic-authenticator	679c1e80-fcc8-4163-ae01-167899dcf2c9	41e596b0-40cd-453b-a303-a2c0e3d4b33b	0	10	f	\N	\N
618942f8-f77f-42a5-a839-37f005cfd85e	\N	auth-cookie	77d679c9-57ee-4dfb-843c-31bd47ea51bf	2e9164d5-a486-4c61-a0ce-db84cb083279	2	10	f	\N	\N
8ea26072-0710-4b95-9f00-a8b1253b9cc4	\N	auth-spnego	77d679c9-57ee-4dfb-843c-31bd47ea51bf	2e9164d5-a486-4c61-a0ce-db84cb083279	3	20	f	\N	\N
8b780df5-e70e-4a7d-89bf-93fd514b996f	\N	identity-provider-redirector	77d679c9-57ee-4dfb-843c-31bd47ea51bf	2e9164d5-a486-4c61-a0ce-db84cb083279	2	25	f	\N	\N
5c03bce0-2c7b-456a-bd47-d90ed74fc5e1	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	2e9164d5-a486-4c61-a0ce-db84cb083279	2	30	t	3d84c766-eb0b-4d8f-9090-6a87c1155710	\N
84db1f61-1ca5-4d99-84f2-932584f0bdf1	\N	auth-username-password-form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	3d84c766-eb0b-4d8f-9090-6a87c1155710	0	10	f	\N	\N
a7e334b3-d859-4b66-9021-3b704b7f88d8	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	3d84c766-eb0b-4d8f-9090-6a87c1155710	1	20	t	6a874fc7-dc60-472d-968b-051a133556a2	\N
b087b13a-c6f1-41c1-9242-778e03cabd10	\N	conditional-user-configured	77d679c9-57ee-4dfb-843c-31bd47ea51bf	6a874fc7-dc60-472d-968b-051a133556a2	0	10	f	\N	\N
c10f156a-780c-4e66-8d6b-310d615d567d	\N	auth-otp-form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	6a874fc7-dc60-472d-968b-051a133556a2	0	20	f	\N	\N
6c457469-d2ea-446b-a814-043f21880edd	\N	direct-grant-validate-username	77d679c9-57ee-4dfb-843c-31bd47ea51bf	b391a32e-584c-451f-aa61-c051b750e0f1	0	10	f	\N	\N
6f923a42-ea38-421d-bb80-24d367a550a7	\N	direct-grant-validate-password	77d679c9-57ee-4dfb-843c-31bd47ea51bf	b391a32e-584c-451f-aa61-c051b750e0f1	0	20	f	\N	\N
69a8a868-0ccf-4a3f-a543-808a8c1945c4	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	b391a32e-584c-451f-aa61-c051b750e0f1	1	30	t	16981c97-d553-419a-8533-4ed8063f9157	\N
70e02120-d449-4ac5-aaa0-50c796f6a71e	\N	conditional-user-configured	77d679c9-57ee-4dfb-843c-31bd47ea51bf	16981c97-d553-419a-8533-4ed8063f9157	0	10	f	\N	\N
0a5f0523-a79d-4d96-b454-6ee438dfc244	\N	direct-grant-validate-otp	77d679c9-57ee-4dfb-843c-31bd47ea51bf	16981c97-d553-419a-8533-4ed8063f9157	0	20	f	\N	\N
0061a4e8-78e5-4321-b43b-45d0341bf546	\N	registration-page-form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	0cdf044a-fdd8-43be-95ed-ae78976a1fac	0	10	t	c7546838-6881-47a8-8765-427ebfc7ab1f	\N
b3badc91-08c4-4bd0-86f1-e9d4cb6ef4c2	\N	registration-user-creation	77d679c9-57ee-4dfb-843c-31bd47ea51bf	c7546838-6881-47a8-8765-427ebfc7ab1f	0	20	f	\N	\N
4024322b-6086-431f-8858-b7033f011b69	\N	registration-password-action	77d679c9-57ee-4dfb-843c-31bd47ea51bf	c7546838-6881-47a8-8765-427ebfc7ab1f	0	50	f	\N	\N
895953fe-cd1e-4739-bfa4-52e30e9a7019	\N	registration-recaptcha-action	77d679c9-57ee-4dfb-843c-31bd47ea51bf	c7546838-6881-47a8-8765-427ebfc7ab1f	3	60	f	\N	\N
24e1ec89-c673-44b4-befc-3657508d706f	\N	registration-terms-and-conditions	77d679c9-57ee-4dfb-843c-31bd47ea51bf	c7546838-6881-47a8-8765-427ebfc7ab1f	3	70	f	\N	\N
a0735982-8a55-4982-9f04-3a016525a5ce	\N	reset-credentials-choose-user	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5df5acb8-1cef-4226-b50a-2e960807635e	0	10	f	\N	\N
a2298bfe-1623-4020-be2a-0f7ffac2f4a3	\N	reset-credential-email	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5df5acb8-1cef-4226-b50a-2e960807635e	0	20	f	\N	\N
6e15d0d1-15ce-4e1c-b0bc-0f0cffad4034	\N	reset-password	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5df5acb8-1cef-4226-b50a-2e960807635e	0	30	f	\N	\N
1f1ad81f-f3c3-4138-b422-52775ee97ca4	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5df5acb8-1cef-4226-b50a-2e960807635e	1	40	t	fe085f8a-97ad-48be-ad8f-99aa8dcf2c65	\N
cc59ddc1-37d8-411e-a127-660e85ac9ee7	\N	conditional-user-configured	77d679c9-57ee-4dfb-843c-31bd47ea51bf	fe085f8a-97ad-48be-ad8f-99aa8dcf2c65	0	10	f	\N	\N
19ba9d96-cd29-49aa-a489-ebabf124e959	\N	reset-otp	77d679c9-57ee-4dfb-843c-31bd47ea51bf	fe085f8a-97ad-48be-ad8f-99aa8dcf2c65	0	20	f	\N	\N
21f29805-cb6a-477a-bf83-c799f7028334	\N	client-secret	77d679c9-57ee-4dfb-843c-31bd47ea51bf	9559b9d3-c5ec-4cf6-84f5-6ffafb280727	2	10	f	\N	\N
28651e21-7ddd-4046-af41-63e1b3d74844	\N	client-jwt	77d679c9-57ee-4dfb-843c-31bd47ea51bf	9559b9d3-c5ec-4cf6-84f5-6ffafb280727	2	20	f	\N	\N
2cbcedbb-4883-437b-aa1d-161136765640	\N	client-secret-jwt	77d679c9-57ee-4dfb-843c-31bd47ea51bf	9559b9d3-c5ec-4cf6-84f5-6ffafb280727	2	30	f	\N	\N
cfbe44fe-e23e-44ae-96fd-6ef4d7c5c5dc	\N	client-x509	77d679c9-57ee-4dfb-843c-31bd47ea51bf	9559b9d3-c5ec-4cf6-84f5-6ffafb280727	2	40	f	\N	\N
8753ace5-17db-4ebf-8588-adcc05d1d5d9	\N	idp-review-profile	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f83554d6-f28c-40d4-b28d-8fa1b4cf596f	0	10	f	\N	71561911-61a7-4301-a32f-8f9c50124704
a97f6e22-c558-4661-b316-c3557cdc6954	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f83554d6-f28c-40d4-b28d-8fa1b4cf596f	0	20	t	4611930f-a74d-497e-997c-c0e8608cbbae	\N
106083b2-330a-4b93-93a4-51fb59e34559	\N	idp-create-user-if-unique	77d679c9-57ee-4dfb-843c-31bd47ea51bf	4611930f-a74d-497e-997c-c0e8608cbbae	2	10	f	\N	9be6b1a7-d717-4058-8d86-956d7f9e5b67
482dc599-5614-4e05-9eda-eb65d67539ad	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	4611930f-a74d-497e-997c-c0e8608cbbae	2	20	t	cc35754a-bbd1-4551-af53-03778d750f46	\N
c9781826-c6bf-4bb5-b064-af84e58b01ff	\N	idp-confirm-link	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cc35754a-bbd1-4551-af53-03778d750f46	0	10	f	\N	\N
66d47138-083b-431a-ac41-228fea65e326	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cc35754a-bbd1-4551-af53-03778d750f46	0	20	t	45b48948-265e-4984-a8f9-82e52b9a4da2	\N
7d429e0e-6d0a-4a52-8677-97418c7958d5	\N	idp-email-verification	77d679c9-57ee-4dfb-843c-31bd47ea51bf	45b48948-265e-4984-a8f9-82e52b9a4da2	2	10	f	\N	\N
146d4e26-e1f7-4e4f-a3e9-b1d65cf04359	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	45b48948-265e-4984-a8f9-82e52b9a4da2	2	20	t	70de9b4b-5fb7-4e2d-8ee6-552a003f19e8	\N
2e66274e-c445-4e80-b99c-c3e327335582	\N	idp-username-password-form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	70de9b4b-5fb7-4e2d-8ee6-552a003f19e8	0	10	f	\N	\N
3ba6b394-2c20-4acc-a6df-889a57709685	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	70de9b4b-5fb7-4e2d-8ee6-552a003f19e8	1	20	t	57e2fef7-48e1-4746-93cb-d06367888cdb	\N
e69fc97c-ce06-4e1b-a343-533777b09ee8	\N	conditional-user-configured	77d679c9-57ee-4dfb-843c-31bd47ea51bf	57e2fef7-48e1-4746-93cb-d06367888cdb	0	10	f	\N	\N
71db3407-564d-4441-8788-d2dc97718dce	\N	auth-otp-form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	57e2fef7-48e1-4746-93cb-d06367888cdb	0	20	f	\N	\N
5b369e73-d443-4f57-a08a-f67e428dcd83	\N	http-basic-authenticator	77d679c9-57ee-4dfb-843c-31bd47ea51bf	556af562-d413-421d-be8d-fae05327f1d9	0	10	f	\N	\N
0e4a2069-ae04-4484-a4da-5c3ba97806ec	\N	docker-http-basic-authenticator	77d679c9-57ee-4dfb-843c-31bd47ea51bf	8559f02e-7d49-4427-875d-a6707e7c07e9	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
16d4af84-2400-4742-968e-c80eba53c158	browser	browser based authentication	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
c7116fe3-2764-4efd-b6a5-ddc8bd314b47	forms	Username, password, otp and other auth forms.	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
df2a9e0f-3435-4748-af6b-fbfae1c21838	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
7eaf02e9-a8f8-4fb6-9e0d-55b857e13229	direct grant	OpenID Connect Resource Owner Grant	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
546673c3-c163-493a-908e-bb6b2f348274	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
ce30e49c-087b-4dc7-95cf-9f88207cfd7c	registration	registration flow	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
302f868d-d6dc-4687-8e76-413b3343d6d4	registration form	registration form	679c1e80-fcc8-4163-ae01-167899dcf2c9	form-flow	f	t
ed15735d-45d3-4381-9de8-fc1820426100	reset credentials	Reset credentials for a user if they forgot their password or something	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
0ed6f8fc-e24d-426a-ac0a-8c406b7ff68c	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
38ddc41b-f882-4fdb-9f06-1a6e191d7987	clients	Base authentication for clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	client-flow	t	t
0eb63bf7-69a0-498d-9822-3558f0ef30cc	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
9f7cb60c-a419-4354-94b4-69607edd2862	User creation or linking	Flow for the existing/non-existing user alternatives	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
6e6d538b-5b84-4a65-9b8f-b62fcb5551b8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
5243f6c4-575a-46bb-853d-cfae3d28ceec	Account verification options	Method with which to verity the existing account	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
accd7239-e852-4e34-af1c-8e6aff5c79ce	Verify Existing Account by Re-authentication	Reauthentication of existing account	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
fd0a20ee-181b-4290-931a-2bcc05cf9dcc	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	f	t
0947a44f-0d5a-4692-a0cb-4244707cc45d	saml ecp	SAML ECP Profile Authentication Flow	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
41e596b0-40cd-453b-a303-a2c0e3d4b33b	docker auth	Used by Docker clients to authenticate against the IDP	679c1e80-fcc8-4163-ae01-167899dcf2c9	basic-flow	t	t
2e9164d5-a486-4c61-a0ce-db84cb083279	browser	browser based authentication	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
3d84c766-eb0b-4d8f-9090-6a87c1155710	forms	Username, password, otp and other auth forms.	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
6a874fc7-dc60-472d-968b-051a133556a2	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
b391a32e-584c-451f-aa61-c051b750e0f1	direct grant	OpenID Connect Resource Owner Grant	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
16981c97-d553-419a-8533-4ed8063f9157	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
0cdf044a-fdd8-43be-95ed-ae78976a1fac	registration	registration flow	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
c7546838-6881-47a8-8765-427ebfc7ab1f	registration form	registration form	77d679c9-57ee-4dfb-843c-31bd47ea51bf	form-flow	f	t
5df5acb8-1cef-4226-b50a-2e960807635e	reset credentials	Reset credentials for a user if they forgot their password or something	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
fe085f8a-97ad-48be-ad8f-99aa8dcf2c65	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
9559b9d3-c5ec-4cf6-84f5-6ffafb280727	clients	Base authentication for clients	77d679c9-57ee-4dfb-843c-31bd47ea51bf	client-flow	t	t
f83554d6-f28c-40d4-b28d-8fa1b4cf596f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
4611930f-a74d-497e-997c-c0e8608cbbae	User creation or linking	Flow for the existing/non-existing user alternatives	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
cc35754a-bbd1-4551-af53-03778d750f46	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
45b48948-265e-4984-a8f9-82e52b9a4da2	Account verification options	Method with which to verity the existing account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
70de9b4b-5fb7-4e2d-8ee6-552a003f19e8	Verify Existing Account by Re-authentication	Reauthentication of existing account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
57e2fef7-48e1-4746-93cb-d06367888cdb	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	f	t
556af562-d413-421d-be8d-fae05327f1d9	saml ecp	SAML ECP Profile Authentication Flow	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
8559f02e-7d49-4427-875d-a6707e7c07e9	docker auth	Used by Docker clients to authenticate against the IDP	77d679c9-57ee-4dfb-843c-31bd47ea51bf	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
6ecd54d8-2691-47f7-b69e-e466b572ff78	review profile config	679c1e80-fcc8-4163-ae01-167899dcf2c9
0cd81dd7-8111-4508-ac3e-2762357c7358	create unique user config	679c1e80-fcc8-4163-ae01-167899dcf2c9
71561911-61a7-4301-a32f-8f9c50124704	review profile config	77d679c9-57ee-4dfb-843c-31bd47ea51bf
9be6b1a7-d717-4058-8d86-956d7f9e5b67	create unique user config	77d679c9-57ee-4dfb-843c-31bd47ea51bf
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0cd81dd7-8111-4508-ac3e-2762357c7358	false	require.password.update.after.registration
6ecd54d8-2691-47f7-b69e-e466b572ff78	missing	update.profile.on.first.login
71561911-61a7-4301-a32f-8f9c50124704	missing	update.profile.on.first.login
9be6b1a7-d717-4058-8d86-956d7f9e5b67	false	require.password.update.after.registration
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
d97c2598-271c-46e3-b469-eabf3377e7ca	t	f	master-realm	0	f	\N	\N	t	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b75135d3-4010-4750-8385-8608371afc8c	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2a6f933d-3b99-481b-9553-aac24c27737e	t	f	broker	0	f	\N	\N	t	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
add3bf20-a31e-4dde-9654-90a2335e02f8	t	f	admin-cli	0	t	\N	\N	f	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	f	apache-realm-realm	0	f	\N	\N	t	\N	f	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	0	f	f	apache-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	f	realm-management	0	f	\N	\N	t	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
e580c1a3-095f-4554-8d95-c14c455d9fa3	t	f	account	0	t	\N	/realms/apache-realm/account/	f	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	t	f	account-console	0	t	\N	/realms/apache-realm/account/	f	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
29b02d3c-a7f0-490d-a073-30f777e865f2	t	f	broker	0	f	\N	\N	t	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
4fdc51f0-2572-4794-ad42-cddc24bce561	t	f	security-admin-console	0	t	\N	/admin/apache-realm/console/	f	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9f00080e-699c-42b5-9fba-1a1e4018dbcc	t	f	admin-cli	0	t	\N	\N	f	\N	f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
fc64e80b-6c30-4749-8e19-18f12ff697ff	t	t	apache	0	f	bcqBySiZnGr4rGC5DB3kwG42PebikgLJ		f		f	77d679c9-57ee-4dfb-843c-31bd47ea51bf	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	post.logout.redirect.uris	+
b75135d3-4010-4750-8385-8608371afc8c	post.logout.redirect.uris	+
b75135d3-4010-4750-8385-8608371afc8c	pkce.code.challenge.method	S256
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	post.logout.redirect.uris	+
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	pkce.code.challenge.method	S256
e580c1a3-095f-4554-8d95-c14c455d9fa3	post.logout.redirect.uris	+
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	post.logout.redirect.uris	+
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	pkce.code.challenge.method	S256
4fdc51f0-2572-4794-ad42-cddc24bce561	post.logout.redirect.uris	+
4fdc51f0-2572-4794-ad42-cddc24bce561	pkce.code.challenge.method	S256
fc64e80b-6c30-4749-8e19-18f12ff697ff	client.secret.creation.time	1719997016
fc64e80b-6c30-4749-8e19-18f12ff697ff	oauth2.device.authorization.grant.enabled	false
fc64e80b-6c30-4749-8e19-18f12ff697ff	oidc.ciba.grant.enabled	false
fc64e80b-6c30-4749-8e19-18f12ff697ff	backchannel.logout.session.required	true
fc64e80b-6c30-4749-8e19-18f12ff697ff	backchannel.logout.revoke.offline.tokens	false
fc64e80b-6c30-4749-8e19-18f12ff697ff	display.on.consent.screen	false
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
e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	offline_access	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect built-in scope: offline_access	openid-connect
f575115c-c8e1-47fe-8cf3-443649769537	role_list	679c1e80-fcc8-4163-ae01-167899dcf2c9	SAML role list	saml
e082f59c-2e4b-47fe-8afc-3f64077a7fb7	profile	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect built-in scope: profile	openid-connect
5f3ca531-712c-46f7-9e4b-76e6fafb189e	email	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect built-in scope: email	openid-connect
3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	address	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect built-in scope: address	openid-connect
a8b80292-123f-40d9-a450-e11dcfbd85f2	phone	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect built-in scope: phone	openid-connect
218a26ee-4fa6-48bc-a007-21b7bfb1894c	roles	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect scope for add user roles to the access token	openid-connect
a1773e56-4604-4f99-b5a3-1f62de0e6914	web-origins	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect scope for add allowed web origins to the access token	openid-connect
929bfe79-7096-47c4-9bd1-ac3d137bb588	microprofile-jwt	679c1e80-fcc8-4163-ae01-167899dcf2c9	Microprofile - JWT built-in scope	openid-connect
5b512d0d-7734-4747-a703-31802b076e5a	acr	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
9e606789-a50e-42a0-aab8-2cff18650ea1	basic	679c1e80-fcc8-4163-ae01-167899dcf2c9	OpenID Connect scope for add all basic claims to the token	openid-connect
7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	offline_access	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect built-in scope: offline_access	openid-connect
bba35ded-b631-4dd7-ad55-9834aaa49057	role_list	77d679c9-57ee-4dfb-843c-31bd47ea51bf	SAML role list	saml
8aebf4ef-9d85-415a-a749-e6e7e2da18c7	profile	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect built-in scope: profile	openid-connect
52240ad6-5e8a-4e4e-a43e-f67dd355b221	email	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect built-in scope: email	openid-connect
d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	address	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect built-in scope: address	openid-connect
cb92fe31-a0dd-48ac-8178-32941de350eb	phone	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect built-in scope: phone	openid-connect
e8d6b3aa-f771-45fd-b36b-6ae14afba184	roles	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect scope for add user roles to the access token	openid-connect
6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	web-origins	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect scope for add allowed web origins to the access token	openid-connect
dcf1aff4-da60-46d8-9ad6-82c533380495	microprofile-jwt	77d679c9-57ee-4dfb-843c-31bd47ea51bf	Microprofile - JWT built-in scope	openid-connect
cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	acr	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
afd4db11-a127-40da-8ee6-44e7506356ca	basic	77d679c9-57ee-4dfb-843c-31bd47ea51bf	OpenID Connect scope for add all basic claims to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	true	display.on.consent.screen
e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	${offlineAccessScopeConsentText}	consent.screen.text
f575115c-c8e1-47fe-8cf3-443649769537	true	display.on.consent.screen
f575115c-c8e1-47fe-8cf3-443649769537	${samlRoleListScopeConsentText}	consent.screen.text
e082f59c-2e4b-47fe-8afc-3f64077a7fb7	true	display.on.consent.screen
e082f59c-2e4b-47fe-8afc-3f64077a7fb7	${profileScopeConsentText}	consent.screen.text
e082f59c-2e4b-47fe-8afc-3f64077a7fb7	true	include.in.token.scope
5f3ca531-712c-46f7-9e4b-76e6fafb189e	true	display.on.consent.screen
5f3ca531-712c-46f7-9e4b-76e6fafb189e	${emailScopeConsentText}	consent.screen.text
5f3ca531-712c-46f7-9e4b-76e6fafb189e	true	include.in.token.scope
3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	true	display.on.consent.screen
3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	${addressScopeConsentText}	consent.screen.text
3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	true	include.in.token.scope
a8b80292-123f-40d9-a450-e11dcfbd85f2	true	display.on.consent.screen
a8b80292-123f-40d9-a450-e11dcfbd85f2	${phoneScopeConsentText}	consent.screen.text
a8b80292-123f-40d9-a450-e11dcfbd85f2	true	include.in.token.scope
218a26ee-4fa6-48bc-a007-21b7bfb1894c	true	display.on.consent.screen
218a26ee-4fa6-48bc-a007-21b7bfb1894c	${rolesScopeConsentText}	consent.screen.text
218a26ee-4fa6-48bc-a007-21b7bfb1894c	false	include.in.token.scope
a1773e56-4604-4f99-b5a3-1f62de0e6914	false	display.on.consent.screen
a1773e56-4604-4f99-b5a3-1f62de0e6914		consent.screen.text
a1773e56-4604-4f99-b5a3-1f62de0e6914	false	include.in.token.scope
929bfe79-7096-47c4-9bd1-ac3d137bb588	false	display.on.consent.screen
929bfe79-7096-47c4-9bd1-ac3d137bb588	true	include.in.token.scope
5b512d0d-7734-4747-a703-31802b076e5a	false	display.on.consent.screen
5b512d0d-7734-4747-a703-31802b076e5a	false	include.in.token.scope
9e606789-a50e-42a0-aab8-2cff18650ea1	false	display.on.consent.screen
9e606789-a50e-42a0-aab8-2cff18650ea1	false	include.in.token.scope
7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	true	display.on.consent.screen
7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	${offlineAccessScopeConsentText}	consent.screen.text
bba35ded-b631-4dd7-ad55-9834aaa49057	true	display.on.consent.screen
bba35ded-b631-4dd7-ad55-9834aaa49057	${samlRoleListScopeConsentText}	consent.screen.text
8aebf4ef-9d85-415a-a749-e6e7e2da18c7	true	display.on.consent.screen
8aebf4ef-9d85-415a-a749-e6e7e2da18c7	${profileScopeConsentText}	consent.screen.text
8aebf4ef-9d85-415a-a749-e6e7e2da18c7	true	include.in.token.scope
52240ad6-5e8a-4e4e-a43e-f67dd355b221	true	display.on.consent.screen
52240ad6-5e8a-4e4e-a43e-f67dd355b221	${emailScopeConsentText}	consent.screen.text
52240ad6-5e8a-4e4e-a43e-f67dd355b221	true	include.in.token.scope
d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	true	display.on.consent.screen
d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	${addressScopeConsentText}	consent.screen.text
d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	true	include.in.token.scope
cb92fe31-a0dd-48ac-8178-32941de350eb	true	display.on.consent.screen
cb92fe31-a0dd-48ac-8178-32941de350eb	${phoneScopeConsentText}	consent.screen.text
cb92fe31-a0dd-48ac-8178-32941de350eb	true	include.in.token.scope
e8d6b3aa-f771-45fd-b36b-6ae14afba184	true	display.on.consent.screen
e8d6b3aa-f771-45fd-b36b-6ae14afba184	${rolesScopeConsentText}	consent.screen.text
e8d6b3aa-f771-45fd-b36b-6ae14afba184	false	include.in.token.scope
6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	false	display.on.consent.screen
6e5f9c0b-9ad3-42b2-9342-d582b73f41e9		consent.screen.text
6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	false	include.in.token.scope
dcf1aff4-da60-46d8-9ad6-82c533380495	false	display.on.consent.screen
dcf1aff4-da60-46d8-9ad6-82c533380495	true	include.in.token.scope
cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	false	display.on.consent.screen
cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	false	include.in.token.scope
afd4db11-a127-40da-8ee6-44e7506356ca	false	display.on.consent.screen
afd4db11-a127-40da-8ee6-44e7506356ca	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	9e606789-a50e-42a0-aab8-2cff18650ea1	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	5b512d0d-7734-4747-a703-31802b076e5a	t
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
b75135d3-4010-4750-8385-8608371afc8c	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
b75135d3-4010-4750-8385-8608371afc8c	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
b75135d3-4010-4750-8385-8608371afc8c	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
b75135d3-4010-4750-8385-8608371afc8c	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
b75135d3-4010-4750-8385-8608371afc8c	9e606789-a50e-42a0-aab8-2cff18650ea1	t
b75135d3-4010-4750-8385-8608371afc8c	5b512d0d-7734-4747-a703-31802b076e5a	t
b75135d3-4010-4750-8385-8608371afc8c	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
b75135d3-4010-4750-8385-8608371afc8c	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
b75135d3-4010-4750-8385-8608371afc8c	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
b75135d3-4010-4750-8385-8608371afc8c	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
add3bf20-a31e-4dde-9654-90a2335e02f8	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
add3bf20-a31e-4dde-9654-90a2335e02f8	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
add3bf20-a31e-4dde-9654-90a2335e02f8	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
add3bf20-a31e-4dde-9654-90a2335e02f8	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
add3bf20-a31e-4dde-9654-90a2335e02f8	9e606789-a50e-42a0-aab8-2cff18650ea1	t
add3bf20-a31e-4dde-9654-90a2335e02f8	5b512d0d-7734-4747-a703-31802b076e5a	t
add3bf20-a31e-4dde-9654-90a2335e02f8	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
add3bf20-a31e-4dde-9654-90a2335e02f8	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
add3bf20-a31e-4dde-9654-90a2335e02f8	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
add3bf20-a31e-4dde-9654-90a2335e02f8	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
2a6f933d-3b99-481b-9553-aac24c27737e	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
2a6f933d-3b99-481b-9553-aac24c27737e	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
2a6f933d-3b99-481b-9553-aac24c27737e	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
2a6f933d-3b99-481b-9553-aac24c27737e	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
2a6f933d-3b99-481b-9553-aac24c27737e	9e606789-a50e-42a0-aab8-2cff18650ea1	t
2a6f933d-3b99-481b-9553-aac24c27737e	5b512d0d-7734-4747-a703-31802b076e5a	t
2a6f933d-3b99-481b-9553-aac24c27737e	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
2a6f933d-3b99-481b-9553-aac24c27737e	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
2a6f933d-3b99-481b-9553-aac24c27737e	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
2a6f933d-3b99-481b-9553-aac24c27737e	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
d97c2598-271c-46e3-b469-eabf3377e7ca	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
d97c2598-271c-46e3-b469-eabf3377e7ca	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
d97c2598-271c-46e3-b469-eabf3377e7ca	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
d97c2598-271c-46e3-b469-eabf3377e7ca	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
d97c2598-271c-46e3-b469-eabf3377e7ca	9e606789-a50e-42a0-aab8-2cff18650ea1	t
d97c2598-271c-46e3-b469-eabf3377e7ca	5b512d0d-7734-4747-a703-31802b076e5a	t
d97c2598-271c-46e3-b469-eabf3377e7ca	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
d97c2598-271c-46e3-b469-eabf3377e7ca	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
d97c2598-271c-46e3-b469-eabf3377e7ca	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
d97c2598-271c-46e3-b469-eabf3377e7ca	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	9e606789-a50e-42a0-aab8-2cff18650ea1	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	5b512d0d-7734-4747-a703-31802b076e5a	t
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
e580c1a3-095f-4554-8d95-c14c455d9fa3	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	afd4db11-a127-40da-8ee6-44e7506356ca	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
e580c1a3-095f-4554-8d95-c14c455d9fa3	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
e580c1a3-095f-4554-8d95-c14c455d9fa3	cb92fe31-a0dd-48ac-8178-32941de350eb	f
e580c1a3-095f-4554-8d95-c14c455d9fa3	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
e580c1a3-095f-4554-8d95-c14c455d9fa3	dcf1aff4-da60-46d8-9ad6-82c533380495	f
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	afd4db11-a127-40da-8ee6-44e7506356ca	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	cb92fe31-a0dd-48ac-8178-32941de350eb	f
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	dcf1aff4-da60-46d8-9ad6-82c533380495	f
9f00080e-699c-42b5-9fba-1a1e4018dbcc	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	afd4db11-a127-40da-8ee6-44e7506356ca	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
9f00080e-699c-42b5-9fba-1a1e4018dbcc	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
9f00080e-699c-42b5-9fba-1a1e4018dbcc	cb92fe31-a0dd-48ac-8178-32941de350eb	f
9f00080e-699c-42b5-9fba-1a1e4018dbcc	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
9f00080e-699c-42b5-9fba-1a1e4018dbcc	dcf1aff4-da60-46d8-9ad6-82c533380495	f
29b02d3c-a7f0-490d-a073-30f777e865f2	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
29b02d3c-a7f0-490d-a073-30f777e865f2	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
29b02d3c-a7f0-490d-a073-30f777e865f2	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
29b02d3c-a7f0-490d-a073-30f777e865f2	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
29b02d3c-a7f0-490d-a073-30f777e865f2	afd4db11-a127-40da-8ee6-44e7506356ca	t
29b02d3c-a7f0-490d-a073-30f777e865f2	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
29b02d3c-a7f0-490d-a073-30f777e865f2	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
29b02d3c-a7f0-490d-a073-30f777e865f2	cb92fe31-a0dd-48ac-8178-32941de350eb	f
29b02d3c-a7f0-490d-a073-30f777e865f2	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
29b02d3c-a7f0-490d-a073-30f777e865f2	dcf1aff4-da60-46d8-9ad6-82c533380495	f
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	afd4db11-a127-40da-8ee6-44e7506356ca	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	cb92fe31-a0dd-48ac-8178-32941de350eb	f
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
cfd2d61a-e607-4d59-bbaa-c13ae4083abd	dcf1aff4-da60-46d8-9ad6-82c533380495	f
4fdc51f0-2572-4794-ad42-cddc24bce561	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
4fdc51f0-2572-4794-ad42-cddc24bce561	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
4fdc51f0-2572-4794-ad42-cddc24bce561	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
4fdc51f0-2572-4794-ad42-cddc24bce561	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
4fdc51f0-2572-4794-ad42-cddc24bce561	afd4db11-a127-40da-8ee6-44e7506356ca	t
4fdc51f0-2572-4794-ad42-cddc24bce561	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
4fdc51f0-2572-4794-ad42-cddc24bce561	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
4fdc51f0-2572-4794-ad42-cddc24bce561	cb92fe31-a0dd-48ac-8178-32941de350eb	f
4fdc51f0-2572-4794-ad42-cddc24bce561	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
4fdc51f0-2572-4794-ad42-cddc24bce561	dcf1aff4-da60-46d8-9ad6-82c533380495	f
fc64e80b-6c30-4749-8e19-18f12ff697ff	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	afd4db11-a127-40da-8ee6-44e7506356ca	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
fc64e80b-6c30-4749-8e19-18f12ff697ff	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
fc64e80b-6c30-4749-8e19-18f12ff697ff	cb92fe31-a0dd-48ac-8178-32941de350eb	f
fc64e80b-6c30-4749-8e19-18f12ff697ff	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
fc64e80b-6c30-4749-8e19-18f12ff697ff	dcf1aff4-da60-46d8-9ad6-82c533380495	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	81ac6a02-2aa5-4e3a-bef5-1d5b8a691c7f
7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	a82dbd67-a06a-40c5-aa25-427f97e84b37
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
acaa346d-240e-492b-b146-9484a77996b6	Trusted Hosts	679c1e80-fcc8-4163-ae01-167899dcf2c9	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
4af04722-2da8-4c24-87db-4fcd78096fca	Consent Required	679c1e80-fcc8-4163-ae01-167899dcf2c9	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
0e53adf6-02a7-4c6e-b183-2b938ebff539	Full Scope Disabled	679c1e80-fcc8-4163-ae01-167899dcf2c9	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
e9086c01-f4ab-4514-903c-8ce361f2541f	Max Clients Limit	679c1e80-fcc8-4163-ae01-167899dcf2c9	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
8ee879cf-ff86-434d-88d9-6215431053b5	Allowed Protocol Mapper Types	679c1e80-fcc8-4163-ae01-167899dcf2c9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
38504075-080a-48f1-921d-776490a16f0b	Allowed Client Scopes	679c1e80-fcc8-4163-ae01-167899dcf2c9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	anonymous
db640e39-c903-48e8-a5a4-6f10718ff5e1	Allowed Protocol Mapper Types	679c1e80-fcc8-4163-ae01-167899dcf2c9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	authenticated
801da2cc-87ba-4d05-9555-6855c3a79640	Allowed Client Scopes	679c1e80-fcc8-4163-ae01-167899dcf2c9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	authenticated
e77d1df9-656d-4f1e-beae-034f5b8d4aba	rsa-generated	679c1e80-fcc8-4163-ae01-167899dcf2c9	rsa-generated	org.keycloak.keys.KeyProvider	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N
ac464836-9302-490a-a74e-55bff7f59019	rsa-enc-generated	679c1e80-fcc8-4163-ae01-167899dcf2c9	rsa-enc-generated	org.keycloak.keys.KeyProvider	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N
590ddac2-dbee-4008-89cd-3ae390afa1e0	hmac-generated-hs512	679c1e80-fcc8-4163-ae01-167899dcf2c9	hmac-generated	org.keycloak.keys.KeyProvider	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N
aeb9b84a-78aa-4b78-b156-d451b99cba1b	aes-generated	679c1e80-fcc8-4163-ae01-167899dcf2c9	aes-generated	org.keycloak.keys.KeyProvider	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N
a4e9a97e-52eb-4b5c-b6a9-44ff21a1515c	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N
f69a8306-027a-4950-bcc5-42c755691fb9	rsa-generated	77d679c9-57ee-4dfb-843c-31bd47ea51bf	rsa-generated	org.keycloak.keys.KeyProvider	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N
141add2d-6450-448e-9358-62df4ffd0cf2	rsa-enc-generated	77d679c9-57ee-4dfb-843c-31bd47ea51bf	rsa-enc-generated	org.keycloak.keys.KeyProvider	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N
46ba162d-b144-4ff3-8e73-1de9eda1c5d3	hmac-generated-hs512	77d679c9-57ee-4dfb-843c-31bd47ea51bf	hmac-generated	org.keycloak.keys.KeyProvider	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N
10d13b9b-4499-443f-9ca4-37f397ba144e	aes-generated	77d679c9-57ee-4dfb-843c-31bd47ea51bf	aes-generated	org.keycloak.keys.KeyProvider	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N
741c41bb-b760-421e-a1c0-688d2d1999f9	Trusted Hosts	77d679c9-57ee-4dfb-843c-31bd47ea51bf	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
f98ca9fe-a319-48a1-9af3-adaeade94930	Consent Required	77d679c9-57ee-4dfb-843c-31bd47ea51bf	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
2c6738b6-daea-4746-adee-27ac5a6b2fc5	Full Scope Disabled	77d679c9-57ee-4dfb-843c-31bd47ea51bf	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
23266fda-d87e-4d74-a6c7-ca101d45cb5c	Max Clients Limit	77d679c9-57ee-4dfb-843c-31bd47ea51bf	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
a3e0f970-60c0-491b-b92d-05d00f06496f	Allowed Protocol Mapper Types	77d679c9-57ee-4dfb-843c-31bd47ea51bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
812fc8b5-1c25-40a3-af73-b042d47b6060	Allowed Client Scopes	77d679c9-57ee-4dfb-843c-31bd47ea51bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	anonymous
f77da453-e671-47b0-8233-880f45ba6959	Allowed Protocol Mapper Types	77d679c9-57ee-4dfb-843c-31bd47ea51bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	authenticated
1d40f63e-1e4b-4cd7-8723-7b37bd8455e5	Allowed Client Scopes	77d679c9-57ee-4dfb-843c-31bd47ea51bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
59c2f370-1bc0-4fdb-85f2-b392a60e316f	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	oidc-full-name-mapper
ca498202-c8de-4eb8-9752-6ff90b7e2d01	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	saml-user-property-mapper
137ccc25-55de-469d-82fc-3330389cb661	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
81d63f91-3125-49f6-996c-09f4b7f45459	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	saml-role-list-mapper
d8e0f2a0-67ca-47a9-91a0-b91951165455	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
46fe6c9b-8b9e-4a91-9fc9-620d143bc2a2	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	saml-user-attribute-mapper
142aaf62-48f2-47fd-a5a9-a6bd6ee5388b	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	oidc-address-mapper
f5fc8836-7dbd-47a1-9e37-19adb622c542	8ee879cf-ff86-434d-88d9-6215431053b5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b6f14578-1f82-49de-a71c-1b479c1c532d	801da2cc-87ba-4d05-9555-6855c3a79640	allow-default-scopes	true
3db3aeb8-271f-4fac-9050-7b13e2d7ae3f	e9086c01-f4ab-4514-903c-8ce361f2541f	max-clients	200
06767d2d-893b-4a88-923c-8d0a81099ac4	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	oidc-full-name-mapper
8008950e-f126-4c61-a954-7c502f5794d2	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	saml-user-attribute-mapper
ba46f8a7-5831-4c80-9300-6afcc9b87726	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2fba8383-65a6-40d4-a968-8a875b8b56c7	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	saml-user-property-mapper
4e39db9e-7b43-46da-990a-615a5653fbf9	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	oidc-address-mapper
ebb6b9fc-db1b-4cc0-8082-98bb595a1c39	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
200e981c-c39d-4021-a602-6d542670e1ef	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
611d9897-78b2-44ee-b13b-88e11cdd5ef1	db640e39-c903-48e8-a5a4-6f10718ff5e1	allowed-protocol-mapper-types	saml-role-list-mapper
1fc6a0ad-47e8-4f53-9335-a3e2d9b74ec6	38504075-080a-48f1-921d-776490a16f0b	allow-default-scopes	true
cbc5a242-748a-4412-8558-301455eaea90	acaa346d-240e-492b-b146-9484a77996b6	client-uris-must-match	true
058e87cb-c32d-4249-bcae-2a7d217397b9	acaa346d-240e-492b-b146-9484a77996b6	host-sending-registration-request-must-match	true
4def9af1-20b3-4122-966b-e0dd9447d99b	e77d1df9-656d-4f1e-beae-034f5b8d4aba	priority	100
9b4c98cf-d74d-448d-9baa-0b2d1b37de55	e77d1df9-656d-4f1e-beae-034f5b8d4aba	certificate	MIICmzCCAYMCBgGQd86PmjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzAzMDg1NDA0WhcNMzQwNzAzMDg1NTQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDyE7RGZoSw/CVxSY/HEbh13qHv9Yu927Iv6A/k0jA557kq8n+7EhQZhm54737GSgQGzNAv18vsG76gzQjlTN8VS4qWxa9V2g5ELysQXdYCLjkBiIfl4MqhEtNvIW2qpAM7HJKXpRTQoEd7l5sIR3lGuJ+pQLtd208Y68XcKbVo+vW/EgqTTDYY9Qb4wcd7KxLP8tPEwb/O23fZ1J+TJwNZnV3TAufsvynhKj/mR/9m6FhasMt3P7GmyWuVw5oLaUfpU6tYNvenKr18LIHWzmg4hAhLH1u1m/JqYBReSxLqVMYwb9rcnWzcg52YTwWsT2fDCRZQn5drN+8xF8HUeSg9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAOlXsCHo5aHUovkaOCuKHTcWoA15F6t+1I0OqUmAqzSHyA7U96ysNB6D8NSMuQNB8clh3ZVAvTK/N+NCfdth9Z0kMvV+iuu/sndOn2OXghU4VS/Hbks3navIukl3BsggBYbCpGk93SByQCH+nf67L23QCISsHu0paUZZnsfOaqMZSignB/mZuFKyK4gbVyn1P/BpPTGO3gSPnech/5mKQ0mofnPBDKsMCR2WNSvoByj9nuJLMWVVwmH6wv7ZF4QA298Pa7Of+afafWPdiPtQu9zgunVPkSXwE5yr1WKM6SQD4dPL5dlIonIdEq/WAqp+Jt/KOy7/MauiHy+rSlUt0ew=
292b76b1-6800-4de5-a69a-8342b7dac9eb	e77d1df9-656d-4f1e-beae-034f5b8d4aba	privateKey	MIIEpAIBAAKCAQEA8hO0RmaEsPwlcUmPxxG4dd6h7/WLvduyL+gP5NIwOee5KvJ/uxIUGYZueO9+xkoEBszQL9fL7Bu+oM0I5UzfFUuKlsWvVdoORC8rEF3WAi45AYiH5eDKoRLTbyFtqqQDOxySl6UU0KBHe5ebCEd5RrifqUC7XdtPGOvF3Cm1aPr1vxIKk0w2GPUG+MHHeysSz/LTxMG/ztt32dSfkycDWZ1d0wLn7L8p4So/5kf/ZuhYWrDLdz+xpslrlcOaC2lH6VOrWDb3pyq9fCyB1s5oOIQISx9btZvyamAUXksS6lTGMG/a3J1s3IOdmE8FrE9nwwkWUJ+XazfvMRfB1HkoPQIDAQABAoIBABDb8vLxOl4KHYBzj1Ydo5Nf7zbDStls5s7D0nGM+utZelGlpGQuqOQzMtfs1A8ywe+ITZp7ZLobn43a4br4fNPimDMSbvjjcBlrEIx6AIjT18gFznMh0fLgWQXVFeprtEbmYUY66sVx2DChGRy9P5K/km0K81Ggz7QsXXINHJOEPjLRmFqZfapsX6Iyh7eJNpD8QbOUJDh2zsBZ9cbwkVFMEUKp2KzQJ0xZJ746oGk2ODK6fjDuCWnin7slybri/x3gwMBuVp/LvwAnjXJ+UqqSAsbG+EGF26YjLrXfEE95G9E3bPbF5RwjOkac/8t4iZOju2+6z98OZlK83p8vQSkCgYEA+gEcQA8SURSEiQ3m9i8Jr5D/m4geKbUTi//A/nCcAaYxwY6SiPUjMZPHjMwXh/kXNcrQH/nVnA2hH1o9v76440p05cPOsZSVTeB5fJYCoamem9L4uXZj+Y1OOaGMx2WKBBxLgunmE+26rFKT4ej6Y+HniWoDno/wK9TDpz7g+IkCgYEA9+HslTxmaeUR6P/kgvd4Kgn4hga4GQhLPUv+ZJRXI4eQ4LIkKAUfQHk4koWJAfm/1j47D3F0cP+HsnOqfDAgo51SMZvrBqS6flnVu7ureVS1ehxSKADez3wd75lZtHGEK0SEsVdjYEdJeSBqwbHXjrcsgue+wUtw93HbBH8jXRUCgYEA130nhYu4JQ0DZEMIZgCLX7oiqEP+g8Khk5WiG26i+cTvtD+YzNZHPI99fD3atogc2m/zTuyAk58n1ydofCL/qGJgOj+5pFVHEDZBYQLIR+I1ZWjGnM2QROTonUJDXweFnB9rcu77MwhBVBFliF7RnFB2y3oGnqDAynb9IeZP8ckCgYEApVwSXe/ABi5oxz1FbFS31Zt3Lbl3wEM3Jfn3B5OpmasK68oKsqPQGEuFgMESB75aygoTjhbKbcMY++OLPHNCosMFHND9dR4YxscY/LaSCkuHEKGp8MO73z/WHIr5O5VqbQ61UjSQt552lhYZAYOo36y0RdNg/kNcZcWPLK2/oo0CgYBB7XI/fsXz1Ybmt13GlSVN1132gNQL9h7o7cdIIurathfBrPhVTdDgtIgpsfJtsdtj2xrXe/+zLEtayGZhTk03vt8+vVgj5YjgDzPIhAboAQBTJ1O6V0GUh8mhVXZSCAWBJ5MzbFb8hFmZ6UWhYP4XiFtDaS+D3gOxVqWkfL20FQ==
cd4c7552-4916-495c-97db-78c1e2d34ecc	e77d1df9-656d-4f1e-beae-034f5b8d4aba	keyUse	SIG
5c9123e3-1c19-43bd-b978-d699ad8901ff	a4e9a97e-52eb-4b5c-b6a9-44ff21a1515c	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
10c4486d-79e8-4e72-992f-d1067679c97c	aeb9b84a-78aa-4b78-b156-d451b99cba1b	kid	187db040-71b7-4325-9873-890ee6206814
5a5e52ba-1820-42ce-8b0c-108796727997	aeb9b84a-78aa-4b78-b156-d451b99cba1b	priority	100
ef62fe01-2131-4413-9576-a430941a7b31	aeb9b84a-78aa-4b78-b156-d451b99cba1b	secret	DXp-HJmTpzQIKzjae2CCKg
f15ee70f-1d4c-4699-9244-5cd638697420	ac464836-9302-490a-a74e-55bff7f59019	algorithm	RSA-OAEP
e2a38018-53d3-4bf0-ab59-766f0e0467fc	ac464836-9302-490a-a74e-55bff7f59019	certificate	MIICmzCCAYMCBgGQd86QdjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNzAzMDg1NDA0WhcNMzQwNzAzMDg1NTQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCsbDKRQ1iRmLcBy1UUzRs0nxhFI49dELnY5+ZkO/gHzt+ll4Xw88vNztJnH6hBo5D86ki5G0APRdb8rJLpAf11V4sukU2Watg/Tf4pdxkBmUuWlU1AnG7zcVrDz6lILjAsaUWqWYiZWtrfwx+tqk9XrOWsf6aKaexCvUra+/09r84OiH4/QDxKELdc2qIwUpzqrQyqzgQ522/Ggoo+pjOYA7P9423u3RhCInJagquZCvjspRgnGnr5CzwQBrIep7vsZslXI2+j1EnkcOxO8TufwTWEkdk/2sSUX1GIzFY0Js0D9tKBPWUkthuvlYR9LfYHYKMfx7xO6VcNwPoA04HzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEAyY25XadvIUKf/RUuRnCvO/wqS0To4LAXtpWFBczaln1z1cuDYmm+jKy5I9K9JOk6Io1nZ/sOdQ2cNgozIBm1qLyAkVpinQfPLyGZK3FcO/65L3GUxsqATTAJIVIHO36UJkKXde5LwdD9g7rTByZ6ZZEwZyC84SskFYiUvwPgNDvAUEGOg+bU1e5uSFj/HafLiCR7WiDduM5FElMacNxu9WSRzz9kvMIlOubVbW3qml8T7n1SnhbVGWcbFgYn8prrFzkEwN3Po8BwVBm5B6pFFnq/bugaUWU8HcDFSfe/TswCmePnyaWxOWpPsgmUoyAOpK4loNTc7GFSPZZD40gE=
f8bc2062-2209-4887-a31a-d5d9682cc292	ac464836-9302-490a-a74e-55bff7f59019	privateKey	MIIEpAIBAAKCAQEArGwykUNYkZi3ActVFM0bNJ8YRSOPXRC52OfmZDv4B87fpZeF8PPLzc7SZx+oQaOQ/OpIuRtAD0XW/KyS6QH9dVeLLpFNlmrYP03+KXcZAZlLlpVNQJxu83Faw8+pSC4wLGlFqlmImVra38MfrapPV6zlrH+mimnsQr1K2vv9Pa/ODoh+P0A8ShC3XNqiMFKc6q0Mqs4EOdtvxoKKPqYzmAOz/eNt7t0YQiJyWoKrmQr47KUYJxp6+Qs8EAayHqe77GbJVyNvo9RJ5HDsTvE7n8E1hJHZP9rElF9RiMxWNCbNA/bSgT1lJLYbr5WEfS32B2CjH8e8TulXDcD6ANOB8wIDAQABAoIBACFUGMIzfl9GYbmbECshKm0Vg595rDCVFxdyW/psDRmVR22+yEk3FuIFZG5ClEd70n7Q2pXNSqipG1FkGlGn7NJNxb2OoKy+omY6MTLarp68fvvwiCpBEsFD3AOVlGc7ZlxvTOQMwnbCNSSjlu/+x69u4EZjtlFzABQ2es2xf9X4YFihciJvVHveDY5TvkO5JIBrmt/NTM6l5WcOoFT9ZnXKsA1RTu1UhQjivW7t0NTs2qmYcSpe/o+VqIqxjmSCsDkAKUYcubb4cUg6tZQtBVCmr9ArQ21glg+sQNad3kIZ3PPoFa7ZGSIgiWiGVfnwproZLkT3YGZXmhD05DBWjAECgYEA2iOXbFwyhCRfilTEe3D/Z/98ROXjxWn+/XT0UwpZ48PL7FDxPYUyd7xiuNC8Mn0M8qpFfDVW5c1zwaX4QFA9FhJGrhfwwthOM2HZIP6WwanVfxNRHYS4wtIwZ2hO99HfBqzfNxtlodGQIPbbEB3/0hH521fz4ULIoR77hcbm8oECgYEAyllS+/vCUsxR2CYMro7/nsd1vuO1h5AwwUYTmnnHrM3PEC7mI9SKKjwIgkuMcHxP1h0glYBum5W4x3EL6rENWd/wC5mcP0WJ9nyH1VwaQ6//6WQDyv7fAdWJW2XKTfmt4wAYJAc2GJ6xq1JRPVGMDj1YYnPjlzF5DbTqXy9HknMCgYAgCWQexPeiUpk5frOQkYrhIjOFBuJJxwRtAvUzEO0ct0/GuCiF6X78+Mzi6b0KCTWSmhE0ab0GaQMcKJzqDR67lBmPTfLNGul5QGCcKOfJL4EsdZDPLgPYkPgM59PZL5h6qX7q3/owJs/tF3QazN0aZAt2/FbT+XPvvdYg0pJugQKBgQCqDZmNBU6RUP7zXT7JMIoowU32B95WOFqRAziUWQXy9t+upQtqT0NyLROllKJJIl/h/IaWveG2xYQNsLaoHPWwc1+EECtcjS9dw9hP+eBkxDOYzCHX5ow6OV//PLNhBpUZMcoX9SuEU1HTPhHiK3c9vFZcHzLErKIkX8ecCNroewKBgQDWi5lCFJC/FitpWrjqdjJJGyLzLzRGyOQM7/GlICvT1wcN2MYEijSGZLvngMWVgj8bv5LGbgqeDYiJfPT1OUAA1t96x8NJzjbKi+LCresjFya3j8RACGyNrFuQXhMuLPpmP1caXAb0qtTTSvQZcRtixBva+vT8RdMGu8w233MAjA==
4302d556-107d-4dae-a8ae-895ff25ba5ed	ac464836-9302-490a-a74e-55bff7f59019	keyUse	ENC
883a25fe-c057-40f7-bad0-fbc194d914f2	ac464836-9302-490a-a74e-55bff7f59019	priority	100
79a8591e-1978-4cc5-b65b-0ed592601b04	590ddac2-dbee-4008-89cd-3ae390afa1e0	kid	81248619-b4b7-4f11-90a6-f899bacec162
c1380b79-3b96-4a0c-8923-a48cdd56b090	590ddac2-dbee-4008-89cd-3ae390afa1e0	algorithm	HS512
e40de724-4462-4443-91d2-701e5f79a2ba	590ddac2-dbee-4008-89cd-3ae390afa1e0	secret	_JNV38fTBSr8B694nMMYxfObZ4frNwwo2Y91cVC84kYOWOxrJyt2-LnPToVEY2dcPo5Q7WyoQXJHCW-GBJja0KZAVPdZM51CoMijydf3JVKlfsneRo6fJTAmacW99D2eak7BfVXhS_7lHMmhoTLP0HABsmwDZzDshCYhdZrBf0w
2aa2595c-7cb6-4fe9-a184-24a2bca36859	590ddac2-dbee-4008-89cd-3ae390afa1e0	priority	100
ba108054-75fd-4e88-a034-f252a641a875	141add2d-6450-448e-9358-62df4ffd0cf2	algorithm	RSA-OAEP
4cdfddd1-b741-4945-9b96-2ab680606931	141add2d-6450-448e-9358-62df4ffd0cf2	certificate	MIICpzCCAY8CBgGQd89IYzANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wHhcNMjQwNzAzMDg1NDUxWhcNMzQwNzAzMDg1NjMxWjAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDO3UrpbZZ2DE+9oPdVrwpjjQ1Sy1qIV+Ck5m7yVDpppdAce/n6KPy7LT3PrykCeIBLM7GxhACtTS4iWHvNNfOvTQlFRh7xfgI3yKYs1UrKT6plefTeydl3D5ZsQbpVBEAYJDrA6FBrG94WXAUML4daclVmOkFQQpB4Ct1s/McIMtR/g4pzsVFwOyEKUFcQHY3K9AQYQ/m2GaTgPvZYVwVEdDncfosms1o2nn98GpUV0MS5eREmBa7RdwMM6ZpOVFFiF0APb2C4ixTTeQXP+mhgRNk8anUHOHPupIEzD5gQgl5DRUj4z9MGdhrosaVvF3lUZ2Cf+ScrPPBWbwccIg3ZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGRG5JbWCGiYoCp0EXSClgkaxBbSJHJdZSshzoqqkR2cwXAKL7SjM3EpjdWpUmU0Yh1GjH//13glhFoK2fCGjelzJhmoLPViT0A0psMHrX7fzmC+ZvosbogUS4Ng6bs40W/wFcJSpt4yClsVzL3joBpZujKM33pR4ZppvL960CHYLvH33xOXXoTx0ofYLWxDKOUUBKuuQt2DsZp46JTakuRU8eQ3RAbTmL9Xj8gvBigGUf6HnoOHYBANJNTQsn05b1SsW8F2AsKxblBoD/0fTEa99IvqdhQi/vOX8l2H7+Qe6lfwpIGhiqCimlpMBqhG7Ach4fUs3XJmQuiyzPDKJp4=
e4946356-98ab-4b1f-87a6-1786a429aa28	141add2d-6450-448e-9358-62df4ffd0cf2	privateKey	MIIEowIBAAKCAQEAzt1K6W2WdgxPvaD3Va8KY40NUstaiFfgpOZu8lQ6aaXQHHv5+ij8uy09z68pAniASzOxsYQArU0uIlh7zTXzr00JRUYe8X4CN8imLNVKyk+qZXn03snZdw+WbEG6VQRAGCQ6wOhQaxveFlwFDC+HWnJVZjpBUEKQeArdbPzHCDLUf4OKc7FRcDshClBXEB2NyvQEGEP5thmk4D72WFcFRHQ53H6LJrNaNp5/fBqVFdDEuXkRJgWu0XcDDOmaTlRRYhdAD29guIsU03kFz/poYETZPGp1Bzhz7qSBMw+YEIJeQ0VI+M/TBnYa6LGlbxd5VGdgn/knKzzwVm8HHCIN2QIDAQABAoIBAAHSg+fChgzMLEz+BK/F4aWMMeMvf2tWutfjtR6ADMkEI5fcpRBwbqmHddVFNGtH0c7XybzymL7uFctKVEIz3iMGiV+0L8RDg+l8jwTeFtE+xRWCbtx3kr7bGEwj2BcKTouSkMyaP1ByPRFIBj4Gkn6teysctZlAvN0R227WWzqAlBKAgJY3onDNvkldOWiXikwu+vlhYbpcyqB/gV35YyVYHgRoGzP2fjq+uI1Qm6UfPAoTFWBz4uWEPpkijRstAWtwADetNQOKEhJFDB8UvG7Sz61oj/Ldcbqh2mvx4zxuEoTmyPPzyT6OqA2oosSloT36l5+VnLUgw/e3gh9GGfECgYEA76oDV4CWnxNe8LzOWrcEOwgoEDDuDGJDqIGoSD11JjraAVYwIeZmHdWKgYJsRTX0eRWqUwSM/PRwBWKJ3OadlhQYPdv4eQVPYKYbzumOmEnZWFRulLhQGFnrvKZDwvFmwy0CGFHp0k53m6m9amDFY/upH63M1Yp+9Hwuhiy/rP8CgYEA3PbyHju6CRQO2JsszW1e/SfrqT/ch8AYWvwXVMPu+QXKZKJVrc1xgsbwPThtcWX5V3mg3tqORHTC8wDGNdccKHwSrAZ9sZFZJFve0I+44zO5nl62sUOl4JKKxrV0GnMSnLl0B9OA9s+v450+iR6yzDVX2kpPElWYQDh9LO4aTScCgYEAhFvekJrBlIT8L/P1+v+MZJWymo6LSWeTeiJxL8RRSJXEBGz3FCHMT7m5TqEa7nZH1/9xG3wt6R2OKEstXEQ4z8O1R6SOazfViMj0Hqe6SryuPiwTDitkgK5YlM02Kxlq6WuX9pp2ieEwCVYK+A8NtJQt6QLxVxWv25Ihl5RrHz0CgYAzhKAOzH4jf7m2ZvebLdTn0VbwryMLw43qKLyH1ubwyJjXvcGcNDoy848vtuhNeCkabBFF5E8nRtHtNlEAXJcEGWmBEkJcFDdkcscQeXHyBy1P72VJDyytn30bt1LKl+nPAK485OM8qE+qEg9yiOXHFujUzF6DN9G3p3QH9bvMIQKBgBPdS+aRD9DssnxwastGDPbk0TuRWhglyozmgNL97LATeW6r9cJgRi896PxupUZc3yfFQREx+nGOH8rCnPOW5+VM2fU89k7y/87XxJlEDmhFVRv1JGWcmDhhhjQt3C+HwwjPY0hVeXRl7/ozxgr+eHt/8gBSYMrANuRk0llBs7uV
f4b42a65-6708-4fd5-a799-888fd89a4377	141add2d-6450-448e-9358-62df4ffd0cf2	keyUse	ENC
0f125269-3d84-4254-aaf2-d50e1598a57b	141add2d-6450-448e-9358-62df4ffd0cf2	priority	100
ca88cefc-5700-49a5-a98c-0c8c880f4b64	f69a8306-027a-4950-bcc5-42c755691fb9	keyUse	SIG
5692f21e-bc1e-492b-99d6-fc3e99edd72f	f69a8306-027a-4950-bcc5-42c755691fb9	priority	100
aa767cd9-44f6-448d-8eb3-51396de23fcc	f69a8306-027a-4950-bcc5-42c755691fb9	privateKey	MIIEpQIBAAKCAQEAvkDPJx7x/xBDwRVHLvIr2IAEMHJbR8s94nMai1H7dYjiQHEE+K/9ooBYRzWKKLh7rlw8z6mpSvISfwgmr6jtvwQWyD6VJfaC9MQ7VVjzm/XpN+5T2lQvsTuk7DgRO25i5/G4evYoWFtZnxliKeLu9SW04CkvlkgNIuLL7x173Dst6hG/lVfOn+K9xsMN6Ihc0h+aPFEuTNMv/9fFp2Q0+E3Ds/tae0FcBxpjazJaX2JIp0Cyuy0YQ2WyQM6H+UITXvoKpBnXm1KddsT0+QAxYLvmwS8C/OYCa0kLVOS5cw/n2emh+Wow+XOgRpHMjLdqiNXo806YE6YB3P/lbcK4fwIDAQABAoIBAAT1M7ttay6o51hu7AR1Vh7VszDqAfvxzW01xQF6w5vxUxK31JfVyj0ZAsk+7sNB5M3gjyB1kjj8QZl4MRM5ypGZky2+XRejVWVN1Hf/EetvXJeoXnIIPe1B7yR4D5GQvli/VqiJpU0sJZPnpERlgAb5EmjBr1ZHZA7pLG77lzXgH1pNq9oKCayMbfNmWyV40d8tZSJ2uXPkyhXYUeQW/CagASNQULrl0m4rPuWWDjaV69PXhHDM9VkmaIkt8PEL5QSG/9u6f6CiYsTm8MxNVlNsS3sepBDS2L6CdhlePVT7iFZ5seb+nuzsg8AbkhGGGf1ydE3eDM3Z8gvHUS1pTqkCgYEA9hVWzojg1vlly+/pJcYEyJEsyjncr+kN1lI8MNa4KYIY8pYaohyrqu9l/VP8Fx1IpE2JhAFlzzVWQsXGbYyPVG1w5+3OzLYgs/nD9piiY9Q5UikyegpqgzKmvEdxZlgJCfHrITUoTFcTG6lgkTRIfzo67NwVekD2SEbSdLUqpBcCgYEAxeuC1OlOKc2YhqNdiOz7C79Y2JMtYT3veYLgTIcw3i0bpQYtD7pQcJzv7Flftuhw+GdN9kqlAu/Ee9vk1YxtFXiXPjvsWpiLnX8+8j+RjGEfI0iyiGC+xAu1erkoRVtNntK6kVoTljTJMgCNHhns7lKca8qFvQdptpR/ymaHB9kCgYEA7picFR7kGauwhr6zqPtJMgqIif72Od1WnEIZuCTIZP6OH89oPVxdGhyKH8ipeOPcxemj9sjAJNsLKyzFivwpEGwYd9e8lgHUzYvS9Crj8LUZas8k8O1efpzCy3Tdv6SGBw13tDftPa+DiGN+jOtLi4gzD+sILAQGhuecMKpjkLsCgYEAnRxvJwRs/9ItGfPk9CTqxFCI/qMWivLXfuXdl+JZcITuRPm6G5oS8NIjwsLPsCqkQwv+X1yx0Lr0hj3wUXS/wyOPK9/1p5Ugf03bcgH0UDNovGGhF5F03btNvLXuud/YphMx9uBCXCJa9E5rt1FtO2JouUhzEbMov77yEoGA/0ECgYEAnFOEYRpDdFryPzgz0m1eOQwjX7G9fM2j1I2REAkX1mLO8+FQfJJLd4KDEc2Xjf55Z8oMOEvIfbCY6nlVFxq1vg8Fq7RZD7WRxSUE65+CYEm9aPZOXzHGHC7OPKOpjP7lFYiZej09TN7/D73P7NqfwwrTOk7RaC2jQm/5Oy8FCMg=
d2779b94-aa85-402f-8ad2-24740e8383a9	f69a8306-027a-4950-bcc5-42c755691fb9	certificate	MIICpzCCAY8CBgGQd89HcjANBgkqhkiG9w0BAQsFADAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wHhcNMjQwNzAzMDg1NDUxWhcNMzQwNzAzMDg1NjMxWjAXMRUwEwYDVQQDDAxhcGFjaGUtcmVhbG0wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+QM8nHvH/EEPBFUcu8ivYgAQwcltHyz3icxqLUft1iOJAcQT4r/2igFhHNYoouHuuXDzPqalK8hJ/CCavqO2/BBbIPpUl9oL0xDtVWPOb9ek37lPaVC+xO6TsOBE7bmLn8bh69ihYW1mfGWIp4u71JbTgKS+WSA0i4svvHXvcOy3qEb+VV86f4r3Gww3oiFzSH5o8US5M0y//18WnZDT4TcOz+1p7QVwHGmNrMlpfYkinQLK7LRhDZbJAzof5QhNe+gqkGdebUp12xPT5ADFgu+bBLwL85gJrSQtU5LlzD+fZ6aH5ajD5c6BGkcyMt2qI1ejzTpgTpgHc/+Vtwrh/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKHsxNTCM1CJdmxtQepmmI8RFnisdF/Sdt4tTMSjNHyoxniv4E2NnZuwOrrTTI7+nLHUXAAioFpX2g7DhhpzY7YE2fJf35tmVm/yDQq2hvpIcP0cvY913wg+oEcX6wFzHZiwVvEkfRNy5ApZaLXpicSuxWzZY7/nzdy/gBQGqxBByvSNdAxU+GO4lrWLlklzTfy84hNdN5JgWfNx9SBicIxpG9pItCHlU4aIOkCu3czTH0rn8oSJ/zxNw/e5Nl3PYMPbw11I06FYnN+wqNb6roVi1XSpQz4NrJjyHS2m+jbRiZdQM2Y1N9sUvxR1bQtUy5Xxr2luA7B94tZ7gI4x73c=
35f5c133-6164-4842-b57e-9c51109470c4	46ba162d-b144-4ff3-8e73-1de9eda1c5d3	priority	100
6ccbd9f8-44fa-4b9f-b5c5-a8fbd11f8fa2	46ba162d-b144-4ff3-8e73-1de9eda1c5d3	kid	53e256ea-f988-437a-8deb-ab7c1c2dfc1a
deb37e15-687b-4213-84e4-ef5a91f0612c	46ba162d-b144-4ff3-8e73-1de9eda1c5d3	algorithm	HS512
95b7a17b-208b-4592-aef6-96a186c6ed39	46ba162d-b144-4ff3-8e73-1de9eda1c5d3	secret	oKsy0dhLZeMmHe13QpAQ3jZYPfSfW-bQ-zT-7nSIO_WNXYLh8F_eR9Qi4ie3HknzON0g9_YfE9TQgXTlUjAwiVk3Hg4Nfepv9esDcuxrIqr88XjN-pbA8Cl2Gypai6WTzPf6Wep9A77_tyGou5eV6jKJ7bQS1Tub64TVwjs7Kac
4ee2c7a0-8ea1-4515-8e49-c89806d85962	10d13b9b-4499-443f-9ca4-37f397ba144e	kid	6ca910ad-c94d-4d28-87fa-68dc0329c84a
4643f94f-d94b-442f-86f6-8de33d2f06ba	10d13b9b-4499-443f-9ca4-37f397ba144e	priority	100
995bc233-cef6-47fa-9441-f6a41db67e99	10d13b9b-4499-443f-9ca4-37f397ba144e	secret	7cPAgmCPGRCqPiIH6tB4BA
3cde2f09-5460-4712-ba0d-c6db046022cb	23266fda-d87e-4d74-a6c7-ca101d45cb5c	max-clients	200
78c86c56-291a-4b13-b630-1cd34e91bafc	812fc8b5-1c25-40a3-af73-b042d47b6060	allow-default-scopes	true
90de53c1-959d-4580-8fc4-08162f75eb76	1d40f63e-1e4b-4cd7-8723-7b37bd8455e5	allow-default-scopes	true
e97d3cf5-dbfa-4bf3-8243-d354eae1cccf	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d5c89ea4-0add-46a7-8ff2-be35b2f2639b	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	saml-role-list-mapper
fa22014a-63fb-452f-b855-785031ed125e	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d4706d1f-a2cb-41d8-8801-323d03db9754	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	saml-user-property-mapper
a3e058a7-6e8c-4039-b59d-23be5e600927	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
57415df8-a82d-460e-af63-4ff33e721b02	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	saml-user-attribute-mapper
50ca94b6-2d67-4f1f-ac32-0bbf9320ccfa	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	oidc-address-mapper
6d66a8ba-f368-40c1-97d6-40f449c96f4e	f77da453-e671-47b0-8233-880f45ba6959	allowed-protocol-mapper-types	oidc-full-name-mapper
10d42595-e723-47f6-8a8e-db14cfd4659d	741c41bb-b760-421e-a1c0-688d2d1999f9	host-sending-registration-request-must-match	true
42accf51-40b8-4163-b8be-387ca7059c2a	741c41bb-b760-421e-a1c0-688d2d1999f9	client-uris-must-match	true
9ade79d1-0ce5-4fef-8f0d-f2063e933cce	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9e7bbb90-a786-40eb-989c-ae799852e06a	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	saml-user-attribute-mapper
e0ea6143-bd76-4a04-8d46-ef5c7edc518a	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	oidc-address-mapper
bbfc9b15-efeb-420d-a990-670854f7b5d9	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	saml-role-list-mapper
b0c78b75-5990-4ca3-838a-7f2fdf80edbc	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	saml-user-property-mapper
a937dfd8-50d3-4682-b46b-3957d87f1964	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0e029756-61b7-4c4b-b1d4-6de22ba68ac5	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d12c4875-ef50-4efd-9b38-205b35932239	a3e0f970-60c0-491b-b92d-05d00f06496f	allowed-protocol-mapper-types	oidc-full-name-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
ffb2bae7-c728-45a7-ad88-4c8e9433c823	6e93d7c0-0bfd-4914-b12c-fb7ba187dd95
ffb2bae7-c728-45a7-ad88-4c8e9433c823	e125d8c3-0dba-4d83-8848-2af30e06f676
ffb2bae7-c728-45a7-ad88-4c8e9433c823	696b5c81-3c38-4e1a-81bb-d3a14904a770
ffb2bae7-c728-45a7-ad88-4c8e9433c823	fb6d92fa-8a97-43d8-99a4-38bf43cd9fdf
ffb2bae7-c728-45a7-ad88-4c8e9433c823	be2ce4a7-9877-400b-8c79-72a38801fe2e
ffb2bae7-c728-45a7-ad88-4c8e9433c823	de4412a5-2488-4277-8987-faab17fff77b
ffb2bae7-c728-45a7-ad88-4c8e9433c823	7cedb148-93eb-412b-8c51-84e41fd039cb
ffb2bae7-c728-45a7-ad88-4c8e9433c823	ba9bd16d-6023-453d-8440-aae556da32af
ffb2bae7-c728-45a7-ad88-4c8e9433c823	1104ec9f-2aa8-4cbf-a671-2f8d68f0e76d
ffb2bae7-c728-45a7-ad88-4c8e9433c823	4cdd9787-a880-427f-9e9b-3f4bcdcab43f
ffb2bae7-c728-45a7-ad88-4c8e9433c823	23370f5e-6d0f-491e-ab27-1328e127c197
ffb2bae7-c728-45a7-ad88-4c8e9433c823	0c3ae9c3-314d-48d6-9ae4-bc0b8bad287d
ffb2bae7-c728-45a7-ad88-4c8e9433c823	b9b194e4-d5b5-475a-86d0-c856befd51ac
ffb2bae7-c728-45a7-ad88-4c8e9433c823	2ac879d2-5046-4886-9ec4-c5b5a570e5e2
ffb2bae7-c728-45a7-ad88-4c8e9433c823	9f7a3c55-f123-4e81-b7d6-8ed409303625
ffb2bae7-c728-45a7-ad88-4c8e9433c823	21a6db89-3197-41b1-9422-064d7c0491a5
ffb2bae7-c728-45a7-ad88-4c8e9433c823	8738ad26-5d3b-4f54-a306-5de39d74ce66
ffb2bae7-c728-45a7-ad88-4c8e9433c823	27943dd8-06ef-4238-993d-268bb2b42877
93faad58-aefd-4fb2-802b-01b40d8ad14b	831a6776-c7b1-4839-b208-649672639f54
be2ce4a7-9877-400b-8c79-72a38801fe2e	21a6db89-3197-41b1-9422-064d7c0491a5
fb6d92fa-8a97-43d8-99a4-38bf43cd9fdf	9f7a3c55-f123-4e81-b7d6-8ed409303625
fb6d92fa-8a97-43d8-99a4-38bf43cd9fdf	27943dd8-06ef-4238-993d-268bb2b42877
93faad58-aefd-4fb2-802b-01b40d8ad14b	1f69fe59-c850-4bae-997f-ea92bc31db5d
1f69fe59-c850-4bae-997f-ea92bc31db5d	1d9230b4-629d-43cf-a337-6d3700f9259f
1ea459ec-2f25-415c-8a81-4c79aa671f5b	1ad58dbe-eca0-4bcd-89f3-b37b9b794f33
ffb2bae7-c728-45a7-ad88-4c8e9433c823	17435fef-6961-423e-aed0-68beaf720ad5
93faad58-aefd-4fb2-802b-01b40d8ad14b	81ac6a02-2aa5-4e3a-bef5-1d5b8a691c7f
93faad58-aefd-4fb2-802b-01b40d8ad14b	e109fc06-fd79-4436-bdfd-6a787d9bd91e
ffb2bae7-c728-45a7-ad88-4c8e9433c823	6ad7c93d-05c9-4180-a7f0-643934cf7cec
ffb2bae7-c728-45a7-ad88-4c8e9433c823	24bdc955-ad24-4f7a-8be0-7f5af6856584
ffb2bae7-c728-45a7-ad88-4c8e9433c823	06285f1c-b6ce-488f-8015-88885dc8d034
ffb2bae7-c728-45a7-ad88-4c8e9433c823	eed0ea51-a0ca-41bf-9b85-8dce5504cbd9
ffb2bae7-c728-45a7-ad88-4c8e9433c823	de1bbea7-ffbb-40b4-b2d0-abc1b19efe1f
ffb2bae7-c728-45a7-ad88-4c8e9433c823	9fcc1a0f-ff6e-48ed-9cf5-c507a0b60a58
ffb2bae7-c728-45a7-ad88-4c8e9433c823	1714509b-9ecf-488a-b5de-44025834be19
ffb2bae7-c728-45a7-ad88-4c8e9433c823	a0bd4592-432f-4e3c-99ea-c5fd952a73f6
ffb2bae7-c728-45a7-ad88-4c8e9433c823	a3543b8b-69ea-478e-85f8-6e9616e1717d
ffb2bae7-c728-45a7-ad88-4c8e9433c823	c9750c93-d2c2-4b88-bad1-0fd17b8541cb
ffb2bae7-c728-45a7-ad88-4c8e9433c823	b172f851-494e-402c-a82a-be7738aaf9d6
ffb2bae7-c728-45a7-ad88-4c8e9433c823	57b4ab09-f0dd-40b1-99e0-a2c06c0493eb
ffb2bae7-c728-45a7-ad88-4c8e9433c823	51f6bda5-e040-41da-8ca6-bd4568483d72
ffb2bae7-c728-45a7-ad88-4c8e9433c823	e090bc6e-978e-4c0f-a0e9-0997c9ea6a02
ffb2bae7-c728-45a7-ad88-4c8e9433c823	04893b85-c16d-4f5f-82fc-ac1b1d509070
ffb2bae7-c728-45a7-ad88-4c8e9433c823	743adcb5-188e-4741-b6af-c05534c900f7
ffb2bae7-c728-45a7-ad88-4c8e9433c823	10c17ea3-cda3-420d-84d3-c37d95b58a11
06285f1c-b6ce-488f-8015-88885dc8d034	e090bc6e-978e-4c0f-a0e9-0997c9ea6a02
06285f1c-b6ce-488f-8015-88885dc8d034	10c17ea3-cda3-420d-84d3-c37d95b58a11
eed0ea51-a0ca-41bf-9b85-8dce5504cbd9	04893b85-c16d-4f5f-82fc-ac1b1d509070
05497fe8-d74a-48f3-813c-8d553f08cc30	c0619df0-f9ec-476c-9b1d-75aabb93f4e9
05497fe8-d74a-48f3-813c-8d553f08cc30	e8049461-0fd0-4113-9658-5db03e1aaa42
05497fe8-d74a-48f3-813c-8d553f08cc30	7ca67a81-a372-4917-ba58-bb1f67f2d87b
05497fe8-d74a-48f3-813c-8d553f08cc30	0a30f072-487b-4904-b824-2df7a0baba3d
05497fe8-d74a-48f3-813c-8d553f08cc30	0cecf872-f533-4143-8812-ab58d77c92c5
05497fe8-d74a-48f3-813c-8d553f08cc30	96bfcec3-920e-4a78-8f45-b42bd968edd3
05497fe8-d74a-48f3-813c-8d553f08cc30	462a5eb5-6fb8-4a61-adf4-1c4031edbdcd
05497fe8-d74a-48f3-813c-8d553f08cc30	2e718427-43d5-4522-aa11-73dca673bcfd
05497fe8-d74a-48f3-813c-8d553f08cc30	6e54dd74-8057-4183-936f-2c0dbca5dc07
05497fe8-d74a-48f3-813c-8d553f08cc30	7b15cbd1-b8ea-4e82-b332-090efdb46bb4
05497fe8-d74a-48f3-813c-8d553f08cc30	a2df8878-3802-4c4f-85ae-2c8df44d465e
05497fe8-d74a-48f3-813c-8d553f08cc30	cfbcdfef-b235-4d8f-b5e7-47125927daf4
05497fe8-d74a-48f3-813c-8d553f08cc30	3122d7b5-db97-47f7-9f3a-004febb559bb
05497fe8-d74a-48f3-813c-8d553f08cc30	cfd312c0-27f3-4b91-a877-79d6f6f20385
05497fe8-d74a-48f3-813c-8d553f08cc30	6359483d-2e5d-4bb4-af3f-b0a82c4500a4
05497fe8-d74a-48f3-813c-8d553f08cc30	0b83a54e-b9c9-43d2-b15a-a85bbd62153c
05497fe8-d74a-48f3-813c-8d553f08cc30	cba91d5a-f15e-4998-8ae8-28d207b1819f
0a30f072-487b-4904-b824-2df7a0baba3d	6359483d-2e5d-4bb4-af3f-b0a82c4500a4
7ca67a81-a372-4917-ba58-bb1f67f2d87b	cfd312c0-27f3-4b91-a877-79d6f6f20385
7ca67a81-a372-4917-ba58-bb1f67f2d87b	cba91d5a-f15e-4998-8ae8-28d207b1819f
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	5f20cc36-0a61-4339-ab27-ebaf2fbb8f70
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	10616377-2d45-47cb-8dda-11f4ad03e966
10616377-2d45-47cb-8dda-11f4ad03e966	e77d32ff-2733-4840-816c-45e5d4efd074
35cb8166-a9d4-48d2-8f89-688b7692f2db	5a863089-43ce-47c6-9a6b-2e15efd4b70d
ffb2bae7-c728-45a7-ad88-4c8e9433c823	0b00e659-c316-4687-a003-e6f1af6544f3
05497fe8-d74a-48f3-813c-8d553f08cc30	4e08f058-b3ba-4cf2-b98e-163c6ffa0c41
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	a82dbd67-a06a-40c5-aa25-427f97e84b37
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	36a07d95-7e68-4f37-8527-2126824de88b
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
ca4abc9d-b8fa-4b3d-ba46-546fb6e7bbca	\N	password	67f2291e-b5a0-4e9f-99e4-0703c1c56968	1719996944818	\N	{"value":"QbpegGcwmPLWuZt97H2lZsYv9y8GQ0YNSsK8R7jZb4k=","salt":"qrFyrBcuxilap9Vhv96OrA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
86429627-712a-4ad7-a1a0-00d14a4bd655	\N	password	00d7423f-1185-450e-a1b3-c300a5d32b8c	1719997063236	My password	{"value":"RxEeSFRwpGsRrYdMjCk27EVEAOOalxqaFQT+8EZmFp0=","salt":"XcZ12oVEYGOwWjbAHxVzwA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-07-03 08:55:42.321687	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	9996942097
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-07-03 08:55:42.330754	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	9996942097
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-07-03 08:55:42.356787	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	9996942097
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-07-03 08:55:42.359268	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	9996942097
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-07-03 08:55:42.410611	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	9996942097
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-07-03 08:55:42.414388	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	9996942097
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-07-03 08:55:42.454814	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	9996942097
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-07-03 08:55:42.4578	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	9996942097
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-07-03 08:55:42.460875	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	9996942097
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-07-03 08:55:42.513549	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	9996942097
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-07-03 08:55:42.543195	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	9996942097
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-07-03 08:55:42.545096	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	9996942097
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-07-03 08:55:42.553164	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	9996942097
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-03 08:55:42.562953	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	9996942097
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-03 08:55:42.563795	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-03 08:55:42.565206	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	9996942097
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-07-03 08:55:42.566694	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	9996942097
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-07-03 08:55:42.589076	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	9996942097
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-07-03 08:55:42.608047	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	9996942097
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-07-03 08:55:42.610627	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	9996942097
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-03 08:55:43.12349	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	9996942097
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-03 08:55:42.612026	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	9996942097
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-07-03 08:55:42.613396	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	9996942097
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-07-03 08:55:42.624052	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	9996942097
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-07-03 08:55:42.626431	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	9996942097
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-07-03 08:55:42.627023	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	9996942097
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-07-03 08:55:42.643919	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	9996942097
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-07-03 08:55:42.677935	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	9996942097
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-07-03 08:55:42.679723	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	9996942097
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-07-03 08:55:42.709218	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	9996942097
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-07-03 08:55:42.715525	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	9996942097
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-07-03 08:55:42.724617	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	9996942097
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-07-03 08:55:42.727833	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	9996942097
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-03 08:55:42.731225	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-03 08:55:42.732155	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	9996942097
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-03 08:55:42.744988	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	9996942097
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-07-03 08:55:42.750702	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	9996942097
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-07-03 08:55:42.755859	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	9996942097
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-07-03 08:55:42.758407	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	9996942097
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-07-03 08:55:42.759772	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	9996942097
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-03 08:55:42.760307	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	9996942097
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-03 08:55:42.761317	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	9996942097
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-07-03 08:55:42.764384	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	9996942097
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-07-03 08:55:42.829037	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	9996942097
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-07-03 08:55:42.831344	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	9996942097
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-03 08:55:42.832929	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	9996942097
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-03 08:55:42.83581	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	9996942097
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-03 08:55:42.836424	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	9996942097
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-03 08:55:42.854903	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	9996942097
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-07-03 08:55:42.85719	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	9996942097
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-07-03 08:55:42.875788	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	9996942097
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-07-03 08:55:42.888454	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	9996942097
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-07-03 08:55:42.889747	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-07-03 08:55:42.891164	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	9996942097
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-07-03 08:55:42.892062	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	9996942097
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-03 08:55:42.894387	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	9996942097
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-03 08:55:42.896383	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	9996942097
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-03 08:55:42.905674	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	9996942097
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-07-03 08:55:42.946498	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	9996942097
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-07-03 08:55:42.958882	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	9996942097
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-07-03 08:55:42.961333	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	9996942097
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-03 08:55:42.965765	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	9996942097
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-07-03 08:55:42.967932	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	9996942097
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-07-03 08:55:42.969124	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	9996942097
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-07-03 08:55:42.970293	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	9996942097
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-03 08:55:42.971811	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	9996942097
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-07-03 08:55:42.978018	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	9996942097
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-07-03 08:55:42.980679	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	9996942097
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-07-03 08:55:42.983002	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	9996942097
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-07-03 08:55:42.989029	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	9996942097
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-07-03 08:55:42.991091	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	9996942097
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-07-03 08:55:42.99286	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	9996942097
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-03 08:55:42.99533	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	9996942097
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-03 08:55:42.998058	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	9996942097
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-03 08:55:42.998928	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	9996942097
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-03 08:55:43.005855	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	9996942097
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-07-03 08:55:43.008675	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	9996942097
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-03 08:55:43.009991	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	9996942097
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-03 08:55:43.010515	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	9996942097
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-03 08:55:43.018303	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	9996942097
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-07-03 08:55:43.019042	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	9996942097
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-03 08:55:43.02186	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	9996942097
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-03 08:55:43.022573	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	9996942097
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-03 08:55:43.024454	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	9996942097
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-03 08:55:43.025002	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	9996942097
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-07-03 08:55:43.028052	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	9996942097
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-07-03 08:55:43.029962	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	9996942097
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-03 08:55:43.032924	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	9996942097
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-07-03 08:55:43.036676	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	9996942097
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.039822	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	9996942097
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.042356	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	9996942097
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.04532	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.048047	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	9996942097
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.048979	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	9996942097
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.053274	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	9996942097
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.054197	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	9996942097
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-07-03 08:55:43.057139	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	9996942097
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.061588	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.062135	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.068791	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.071893	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.072595	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.075387	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	9996942097
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-07-03 08:55:43.077699	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	9996942097
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-07-03 08:55:43.080049	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	9996942097
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-07-03 08:55:43.082559	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	9996942097
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-07-03 08:55:43.084621	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	9996942097
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-07-03 08:55:43.087313	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	9996942097
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-03 08:55:43.089728	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	9996942097
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-03 08:55:43.090258	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	9996942097
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-07-03 08:55:43.092361	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-07-03 08:55:43.0945	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	9996942097
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-03 08:55:43.105426	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	9996942097
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-07-03 08:55:43.106733	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	9996942097
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-03 08:55:43.109739	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	9996942097
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-07-03 08:55:43.110706	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	9996942097
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-03 08:55:43.113119	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	9996942097
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-07-03 08:55:43.114495	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	9996942097
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-03 08:55:43.12096	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	9996942097
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-03 08:55:43.125573	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-07-03 08:55:43.128904	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-03 08:55:43.131124	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	9996942097
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-03 08:55:43.131648	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-07-03 08:55:43.132324	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	9996942097
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.134223	125	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.25.1	\N	\N	9996942097
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.136488	126	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.138679	127	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.25.1	\N	\N	9996942097
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.139796	128	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.142347	129	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	9996942097
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.151649	130	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.25.1	\N	\N	9996942097
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.158786	131	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	9996942097
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.15964	132	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.25.1	\N	\N	9996942097
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2024-07-03 08:55:43.163537	133	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.25.1	\N	\N	9996942097
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
679c1e80-fcc8-4163-ae01-167899dcf2c9	e03e8e4d-c3e4-4648-9b1f-3ae44a45db8a	f
679c1e80-fcc8-4163-ae01-167899dcf2c9	f575115c-c8e1-47fe-8cf3-443649769537	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	e082f59c-2e4b-47fe-8afc-3f64077a7fb7	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	5f3ca531-712c-46f7-9e4b-76e6fafb189e	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74	f
679c1e80-fcc8-4163-ae01-167899dcf2c9	a8b80292-123f-40d9-a450-e11dcfbd85f2	f
679c1e80-fcc8-4163-ae01-167899dcf2c9	218a26ee-4fa6-48bc-a007-21b7bfb1894c	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	a1773e56-4604-4f99-b5a3-1f62de0e6914	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	929bfe79-7096-47c4-9bd1-ac3d137bb588	f
679c1e80-fcc8-4163-ae01-167899dcf2c9	5b512d0d-7734-4747-a703-31802b076e5a	t
679c1e80-fcc8-4163-ae01-167899dcf2c9	9e606789-a50e-42a0-aab8-2cff18650ea1	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	7b3cd8ff-abe3-4d87-b4ef-fcf2ababca37	f
77d679c9-57ee-4dfb-843c-31bd47ea51bf	bba35ded-b631-4dd7-ad55-9834aaa49057	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	8aebf4ef-9d85-415a-a749-e6e7e2da18c7	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	52240ad6-5e8a-4e4e-a43e-f67dd355b221	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4	f
77d679c9-57ee-4dfb-843c-31bd47ea51bf	cb92fe31-a0dd-48ac-8178-32941de350eb	f
77d679c9-57ee-4dfb-843c-31bd47ea51bf	e8d6b3aa-f771-45fd-b36b-6ae14afba184	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	dcf1aff4-da60-46d8-9ad6-82c533380495	f
77d679c9-57ee-4dfb-843c-31bd47ea51bf	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce	t
77d679c9-57ee-4dfb-843c-31bd47ea51bf	afd4db11-a127-40da-8ee6-44e7506356ca	t
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
93faad58-aefd-4fb2-802b-01b40d8ad14b	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	${role_default-roles}	default-roles-master	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	\N
6e93d7c0-0bfd-4914-b12c-fb7ba187dd95	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	${role_create-realm}	create-realm	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	\N
ffb2bae7-c728-45a7-ad88-4c8e9433c823	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	${role_admin}	admin	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	\N
e125d8c3-0dba-4d83-8848-2af30e06f676	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_create-client}	create-client	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
696b5c81-3c38-4e1a-81bb-d3a14904a770	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-realm}	view-realm	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
fb6d92fa-8a97-43d8-99a4-38bf43cd9fdf	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-users}	view-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
be2ce4a7-9877-400b-8c79-72a38801fe2e	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-clients}	view-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
de4412a5-2488-4277-8987-faab17fff77b	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-events}	view-events	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
7cedb148-93eb-412b-8c51-84e41fd039cb	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-identity-providers}	view-identity-providers	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
ba9bd16d-6023-453d-8440-aae556da32af	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_view-authorization}	view-authorization	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
1104ec9f-2aa8-4cbf-a671-2f8d68f0e76d	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-realm}	manage-realm	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
4cdd9787-a880-427f-9e9b-3f4bcdcab43f	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-users}	manage-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
23370f5e-6d0f-491e-ab27-1328e127c197	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-clients}	manage-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
0c3ae9c3-314d-48d6-9ae4-bc0b8bad287d	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-events}	manage-events	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
b9b194e4-d5b5-475a-86d0-c856befd51ac	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-identity-providers}	manage-identity-providers	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
2ac879d2-5046-4886-9ec4-c5b5a570e5e2	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_manage-authorization}	manage-authorization	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
9f7a3c55-f123-4e81-b7d6-8ed409303625	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_query-users}	query-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
21a6db89-3197-41b1-9422-064d7c0491a5	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_query-clients}	query-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
8738ad26-5d3b-4f54-a306-5de39d74ce66	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_query-realms}	query-realms	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
27943dd8-06ef-4238-993d-268bb2b42877	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_query-groups}	query-groups	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
831a6776-c7b1-4839-b208-649672639f54	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_view-profile}	view-profile	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
1f69fe59-c850-4bae-997f-ea92bc31db5d	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_manage-account}	manage-account	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
1d9230b4-629d-43cf-a337-6d3700f9259f	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_manage-account-links}	manage-account-links	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
cb616d66-ff4d-4147-96f2-7e045c80235f	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_view-applications}	view-applications	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
1ad58dbe-eca0-4bcd-89f3-b37b9b794f33	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_view-consent}	view-consent	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
1ea459ec-2f25-415c-8a81-4c79aa671f5b	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_manage-consent}	manage-consent	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
ed0e3ef7-628f-44b6-9cba-104ffffb02ca	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_view-groups}	view-groups	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
7bc287c3-e589-4ffb-88bb-4220a58a1a22	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	t	${role_delete-account}	delete-account	679c1e80-fcc8-4163-ae01-167899dcf2c9	b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	\N
d08d5efa-69d2-494c-a903-7795ef7b951e	2a6f933d-3b99-481b-9553-aac24c27737e	t	${role_read-token}	read-token	679c1e80-fcc8-4163-ae01-167899dcf2c9	2a6f933d-3b99-481b-9553-aac24c27737e	\N
17435fef-6961-423e-aed0-68beaf720ad5	d97c2598-271c-46e3-b469-eabf3377e7ca	t	${role_impersonation}	impersonation	679c1e80-fcc8-4163-ae01-167899dcf2c9	d97c2598-271c-46e3-b469-eabf3377e7ca	\N
81ac6a02-2aa5-4e3a-bef5-1d5b8a691c7f	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	${role_offline-access}	offline_access	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	\N
e109fc06-fd79-4436-bdfd-6a787d9bd91e	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	${role_uma_authorization}	uma_authorization	679c1e80-fcc8-4163-ae01-167899dcf2c9	\N	\N
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f	${role_default-roles}	default-roles-apache-realm	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N	\N
6ad7c93d-05c9-4180-a7f0-643934cf7cec	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_create-client}	create-client	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
24bdc955-ad24-4f7a-8be0-7f5af6856584	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-realm}	view-realm	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
06285f1c-b6ce-488f-8015-88885dc8d034	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-users}	view-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
eed0ea51-a0ca-41bf-9b85-8dce5504cbd9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-clients}	view-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
de1bbea7-ffbb-40b4-b2d0-abc1b19efe1f	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-events}	view-events	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
9fcc1a0f-ff6e-48ed-9cf5-c507a0b60a58	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-identity-providers}	view-identity-providers	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
1714509b-9ecf-488a-b5de-44025834be19	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_view-authorization}	view-authorization	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
a0bd4592-432f-4e3c-99ea-c5fd952a73f6	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-realm}	manage-realm	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
a3543b8b-69ea-478e-85f8-6e9616e1717d	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-users}	manage-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
c9750c93-d2c2-4b88-bad1-0fd17b8541cb	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-clients}	manage-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
b172f851-494e-402c-a82a-be7738aaf9d6	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-events}	manage-events	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
57b4ab09-f0dd-40b1-99e0-a2c06c0493eb	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-identity-providers}	manage-identity-providers	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
51f6bda5-e040-41da-8ca6-bd4568483d72	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_manage-authorization}	manage-authorization	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
e090bc6e-978e-4c0f-a0e9-0997c9ea6a02	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_query-users}	query-users	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
04893b85-c16d-4f5f-82fc-ac1b1d509070	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_query-clients}	query-clients	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
743adcb5-188e-4741-b6af-c05534c900f7	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_query-realms}	query-realms	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
10c17ea3-cda3-420d-84d3-c37d95b58a11	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_query-groups}	query-groups	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
05497fe8-d74a-48f3-813c-8d553f08cc30	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_realm-admin}	realm-admin	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
c0619df0-f9ec-476c-9b1d-75aabb93f4e9	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_create-client}	create-client	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
e8049461-0fd0-4113-9658-5db03e1aaa42	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-realm}	view-realm	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
7ca67a81-a372-4917-ba58-bb1f67f2d87b	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-users}	view-users	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
0a30f072-487b-4904-b824-2df7a0baba3d	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-clients}	view-clients	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
0cecf872-f533-4143-8812-ab58d77c92c5	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-events}	view-events	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
96bfcec3-920e-4a78-8f45-b42bd968edd3	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-identity-providers}	view-identity-providers	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
462a5eb5-6fb8-4a61-adf4-1c4031edbdcd	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_view-authorization}	view-authorization	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
2e718427-43d5-4522-aa11-73dca673bcfd	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-realm}	manage-realm	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
6e54dd74-8057-4183-936f-2c0dbca5dc07	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-users}	manage-users	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
7b15cbd1-b8ea-4e82-b332-090efdb46bb4	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-clients}	manage-clients	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
a2df8878-3802-4c4f-85ae-2c8df44d465e	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-events}	manage-events	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
cfbcdfef-b235-4d8f-b5e7-47125927daf4	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-identity-providers}	manage-identity-providers	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
3122d7b5-db97-47f7-9f3a-004febb559bb	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_manage-authorization}	manage-authorization	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
cfd312c0-27f3-4b91-a877-79d6f6f20385	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_query-users}	query-users	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
6359483d-2e5d-4bb4-af3f-b0a82c4500a4	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_query-clients}	query-clients	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
0b83a54e-b9c9-43d2-b15a-a85bbd62153c	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_query-realms}	query-realms	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
cba91d5a-f15e-4998-8ae8-28d207b1819f	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_query-groups}	query-groups	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
5f20cc36-0a61-4339-ab27-ebaf2fbb8f70	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_view-profile}	view-profile	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
10616377-2d45-47cb-8dda-11f4ad03e966	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_manage-account}	manage-account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
e77d32ff-2733-4840-816c-45e5d4efd074	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_manage-account-links}	manage-account-links	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
ff89366c-f91f-4477-9a31-343701924c97	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_view-applications}	view-applications	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
5a863089-43ce-47c6-9a6b-2e15efd4b70d	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_view-consent}	view-consent	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
35cb8166-a9d4-48d2-8f89-688b7692f2db	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_manage-consent}	manage-consent	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
cdff88b4-d730-49da-9e25-479f420c75c0	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_view-groups}	view-groups	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
e1e8ab53-76e7-4355-b0d3-d3425e1fc435	e580c1a3-095f-4554-8d95-c14c455d9fa3	t	${role_delete-account}	delete-account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	e580c1a3-095f-4554-8d95-c14c455d9fa3	\N
0b00e659-c316-4687-a003-e6f1af6544f3	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	t	${role_impersonation}	impersonation	679c1e80-fcc8-4163-ae01-167899dcf2c9	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	\N
4e08f058-b3ba-4cf2-b98e-163c6ffa0c41	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	t	${role_impersonation}	impersonation	77d679c9-57ee-4dfb-843c-31bd47ea51bf	cfd2d61a-e607-4d59-bbaa-c13ae4083abd	\N
b50249d9-71de-4512-9b09-94a92106aa5d	29b02d3c-a7f0-490d-a073-30f777e865f2	t	${role_read-token}	read-token	77d679c9-57ee-4dfb-843c-31bd47ea51bf	29b02d3c-a7f0-490d-a073-30f777e865f2	\N
a82dbd67-a06a-40c5-aa25-427f97e84b37	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f	${role_offline-access}	offline_access	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N	\N
36a07d95-7e68-4f37-8527-2126824de88b	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f	${role_uma_authorization}	uma_authorization	77d679c9-57ee-4dfb-843c-31bd47ea51bf	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
uzml6	25.0.1	1719996943
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
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
bbefb57a-6107-4de2-9870-3bcf6981341c	audience resolve	openid-connect	oidc-audience-resolve-mapper	b75135d3-4010-4750-8385-8608371afc8c	\N
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	locale	openid-connect	oidc-usermodel-attribute-mapper	7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	\N
19e8253e-d0f7-4be0-bf6d-d1ace08d596a	role list	saml	saml-role-list-mapper	\N	f575115c-c8e1-47fe-8cf3-443649769537
09425c64-b272-49d2-984c-5276f89b8421	full name	openid-connect	oidc-full-name-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
f858bb5a-3d35-413b-b1f4-c83aa60e5694	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
2e5d7c67-0d15-47bc-8edd-58d0e679e745	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
34eabb48-6010-4a06-b665-ccc68ed1b990	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
3917b02b-e165-45b8-805d-3d65b8b4dded	username	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
61d4cddf-2094-4fb6-815d-dec07e828489	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
e36f8ec2-d935-4a72-805d-0481a2169964	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
1517e784-990d-46a2-b6c5-98af90a1c28a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
9047af63-0353-4b6f-aafa-fd5992b71f36	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
90ce27ca-dd9e-4f34-b75b-41768412d1a8	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
c255bf09-a57b-4e1e-8fad-f6176227273c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e082f59c-2e4b-47fe-8afc-3f64077a7fb7
11ceb1b8-08e4-4717-9828-a762ead3f41f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	5f3ca531-712c-46f7-9e4b-76e6fafb189e
1f4a480e-1942-421c-84c1-cdb787fa0ff6	email verified	openid-connect	oidc-usermodel-property-mapper	\N	5f3ca531-712c-46f7-9e4b-76e6fafb189e
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	address	openid-connect	oidc-address-mapper	\N	3686ccd1-b1ad-41dc-bec9-ff23bcedeb74
c84a3527-1d41-497d-b197-385a63afd35b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a8b80292-123f-40d9-a450-e11dcfbd85f2
a328e2aa-9800-4205-ad4a-7017afc0e72d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a8b80292-123f-40d9-a450-e11dcfbd85f2
560e1866-48ce-48f1-9f18-64ba6b236373	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	218a26ee-4fa6-48bc-a007-21b7bfb1894c
097a1a34-804e-43d6-b798-cd48b82b8d8f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	218a26ee-4fa6-48bc-a007-21b7bfb1894c
a610876a-f1bd-4d0e-ae67-a8ae9355a9bc	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	218a26ee-4fa6-48bc-a007-21b7bfb1894c
3345e7ef-b77b-4317-9fd6-ddef2aa4fb71	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a1773e56-4604-4f99-b5a3-1f62de0e6914
627a642f-15e3-4d6d-a8d4-70b63aa86298	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	929bfe79-7096-47c4-9bd1-ac3d137bb588
43017c08-4b16-4ddc-9d7d-14ab3644880a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	929bfe79-7096-47c4-9bd1-ac3d137bb588
8875269c-c76b-468c-8af9-3faacf305f7f	acr loa level	openid-connect	oidc-acr-mapper	\N	5b512d0d-7734-4747-a703-31802b076e5a
886ea700-2511-49da-a993-91eb4c510f75	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	9e606789-a50e-42a0-aab8-2cff18650ea1
b7be69d6-446e-43cc-b3b4-9b211dedf27b	sub	openid-connect	oidc-sub-mapper	\N	9e606789-a50e-42a0-aab8-2cff18650ea1
90556abe-b935-4dd1-8baa-e9d99818e68b	audience resolve	openid-connect	oidc-audience-resolve-mapper	7221aedb-3ea8-48b9-9d73-f89d0ac87c11	\N
760bdc5c-25f5-4350-802c-8ae3333ab4d2	role list	saml	saml-role-list-mapper	\N	bba35ded-b631-4dd7-ad55-9834aaa49057
763dbdb3-f0de-4bb5-9fe3-4a2ca3a760cd	full name	openid-connect	oidc-full-name-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
65e9cb1f-08c8-4ba5-b693-aeccb1248149	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
7f221a4d-8b48-4ab1-9c93-96986f6f89be	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
64748278-3037-4291-a454-11e403a97b9d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
474a17c0-c927-41cc-af3d-4b29e9395937	username	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
ab009c33-f0ae-4171-b2e1-b99589efbb8c	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
956d7b8b-79a9-44c5-b244-8530cacb2364	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
8835bbd7-9588-428a-a2e0-5fdebe33c973	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
0199c188-b331-445c-b599-aa41ab0eeabe	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
78b2442b-719b-443d-a254-29f22e3620fa	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
1b9af1fd-a45e-4615-a420-842d55cf8767	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
6821e6c5-304d-4efb-a369-2fa54c37b785	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
8b49f293-79b3-496a-9b53-980b0d3ad7e2	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8aebf4ef-9d85-415a-a749-e6e7e2da18c7
972d3b03-786d-45ab-bfe6-31dde3670f8b	email	openid-connect	oidc-usermodel-attribute-mapper	\N	52240ad6-5e8a-4e4e-a43e-f67dd355b221
2944859f-fa63-445e-a11e-7a4f2a8c0767	email verified	openid-connect	oidc-usermodel-property-mapper	\N	52240ad6-5e8a-4e4e-a43e-f67dd355b221
31e6351d-05d7-496a-91a5-bf21c0504e9f	address	openid-connect	oidc-address-mapper	\N	d4a5c1b0-6d8b-4dc1-b19b-c38db9b911a4
679d758f-1403-4642-b6f5-1e56ed1f9510	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cb92fe31-a0dd-48ac-8178-32941de350eb
fdf265bd-dd96-44f4-ad42-fdddfaa572da	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cb92fe31-a0dd-48ac-8178-32941de350eb
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e8d6b3aa-f771-45fd-b36b-6ae14afba184
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e8d6b3aa-f771-45fd-b36b-6ae14afba184
b8bcbd31-f534-4787-898b-d4bf6ff71180	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e8d6b3aa-f771-45fd-b36b-6ae14afba184
f1d1aece-44ef-4e11-b34b-712b79ec5ef7	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	6e5f9c0b-9ad3-42b2-9342-d582b73f41e9
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	dcf1aff4-da60-46d8-9ad6-82c533380495
9a959bbc-403a-456f-88f6-b940708c4738	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	dcf1aff4-da60-46d8-9ad6-82c533380495
83ef699d-6957-4c14-b6d6-d76d01869187	acr loa level	openid-connect	oidc-acr-mapper	\N	cae57e1c-db26-4afb-a0b8-a2dc3abb37ce
6581555a-1d15-4265-9823-1fe6139e626e	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	afd4db11-a127-40da-8ee6-44e7506356ca
e7ab7861-4b32-4edb-8fd4-77607d025073	sub	openid-connect	oidc-sub-mapper	\N	afd4db11-a127-40da-8ee6-44e7506356ca
befced29-1dd6-4f97-b1fb-00e09edaed9f	locale	openid-connect	oidc-usermodel-attribute-mapper	4fdc51f0-2572-4794-ad42-cddc24bce561	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	true	introspection.token.claim
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	true	userinfo.token.claim
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	locale	user.attribute
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	true	id.token.claim
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	true	access.token.claim
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	locale	claim.name
1eeded43-b88c-49fc-b3f9-69bfb8e7cbe2	String	jsonType.label
19e8253e-d0f7-4be0-bf6d-d1ace08d596a	false	single
19e8253e-d0f7-4be0-bf6d-d1ace08d596a	Basic	attribute.nameformat
19e8253e-d0f7-4be0-bf6d-d1ace08d596a	Role	attribute.name
09425c64-b272-49d2-984c-5276f89b8421	true	introspection.token.claim
09425c64-b272-49d2-984c-5276f89b8421	true	userinfo.token.claim
09425c64-b272-49d2-984c-5276f89b8421	true	id.token.claim
09425c64-b272-49d2-984c-5276f89b8421	true	access.token.claim
1517e784-990d-46a2-b6c5-98af90a1c28a	true	introspection.token.claim
1517e784-990d-46a2-b6c5-98af90a1c28a	true	userinfo.token.claim
1517e784-990d-46a2-b6c5-98af90a1c28a	gender	user.attribute
1517e784-990d-46a2-b6c5-98af90a1c28a	true	id.token.claim
1517e784-990d-46a2-b6c5-98af90a1c28a	true	access.token.claim
1517e784-990d-46a2-b6c5-98af90a1c28a	gender	claim.name
1517e784-990d-46a2-b6c5-98af90a1c28a	String	jsonType.label
2e5d7c67-0d15-47bc-8edd-58d0e679e745	true	introspection.token.claim
2e5d7c67-0d15-47bc-8edd-58d0e679e745	true	userinfo.token.claim
2e5d7c67-0d15-47bc-8edd-58d0e679e745	firstName	user.attribute
2e5d7c67-0d15-47bc-8edd-58d0e679e745	true	id.token.claim
2e5d7c67-0d15-47bc-8edd-58d0e679e745	true	access.token.claim
2e5d7c67-0d15-47bc-8edd-58d0e679e745	given_name	claim.name
2e5d7c67-0d15-47bc-8edd-58d0e679e745	String	jsonType.label
34eabb48-6010-4a06-b665-ccc68ed1b990	true	introspection.token.claim
34eabb48-6010-4a06-b665-ccc68ed1b990	true	userinfo.token.claim
34eabb48-6010-4a06-b665-ccc68ed1b990	middleName	user.attribute
34eabb48-6010-4a06-b665-ccc68ed1b990	true	id.token.claim
34eabb48-6010-4a06-b665-ccc68ed1b990	true	access.token.claim
34eabb48-6010-4a06-b665-ccc68ed1b990	middle_name	claim.name
34eabb48-6010-4a06-b665-ccc68ed1b990	String	jsonType.label
3917b02b-e165-45b8-805d-3d65b8b4dded	true	introspection.token.claim
3917b02b-e165-45b8-805d-3d65b8b4dded	true	userinfo.token.claim
3917b02b-e165-45b8-805d-3d65b8b4dded	username	user.attribute
3917b02b-e165-45b8-805d-3d65b8b4dded	true	id.token.claim
3917b02b-e165-45b8-805d-3d65b8b4dded	true	access.token.claim
3917b02b-e165-45b8-805d-3d65b8b4dded	preferred_username	claim.name
3917b02b-e165-45b8-805d-3d65b8b4dded	String	jsonType.label
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	true	introspection.token.claim
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	true	userinfo.token.claim
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	birthdate	user.attribute
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	true	id.token.claim
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	true	access.token.claim
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	birthdate	claim.name
4b0c68e8-2720-47dd-a3a0-ffc65ea1e869	String	jsonType.label
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	true	introspection.token.claim
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	true	userinfo.token.claim
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	profile	user.attribute
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	true	id.token.claim
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	true	access.token.claim
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	profile	claim.name
519e1ac3-9188-4bde-8d1f-03ffe2e1f845	String	jsonType.label
61d4cddf-2094-4fb6-815d-dec07e828489	true	introspection.token.claim
61d4cddf-2094-4fb6-815d-dec07e828489	true	userinfo.token.claim
61d4cddf-2094-4fb6-815d-dec07e828489	picture	user.attribute
61d4cddf-2094-4fb6-815d-dec07e828489	true	id.token.claim
61d4cddf-2094-4fb6-815d-dec07e828489	true	access.token.claim
61d4cddf-2094-4fb6-815d-dec07e828489	picture	claim.name
61d4cddf-2094-4fb6-815d-dec07e828489	String	jsonType.label
9047af63-0353-4b6f-aafa-fd5992b71f36	true	introspection.token.claim
9047af63-0353-4b6f-aafa-fd5992b71f36	true	userinfo.token.claim
9047af63-0353-4b6f-aafa-fd5992b71f36	zoneinfo	user.attribute
9047af63-0353-4b6f-aafa-fd5992b71f36	true	id.token.claim
9047af63-0353-4b6f-aafa-fd5992b71f36	true	access.token.claim
9047af63-0353-4b6f-aafa-fd5992b71f36	zoneinfo	claim.name
9047af63-0353-4b6f-aafa-fd5992b71f36	String	jsonType.label
90ce27ca-dd9e-4f34-b75b-41768412d1a8	true	introspection.token.claim
90ce27ca-dd9e-4f34-b75b-41768412d1a8	true	userinfo.token.claim
90ce27ca-dd9e-4f34-b75b-41768412d1a8	locale	user.attribute
90ce27ca-dd9e-4f34-b75b-41768412d1a8	true	id.token.claim
90ce27ca-dd9e-4f34-b75b-41768412d1a8	true	access.token.claim
90ce27ca-dd9e-4f34-b75b-41768412d1a8	locale	claim.name
90ce27ca-dd9e-4f34-b75b-41768412d1a8	String	jsonType.label
c255bf09-a57b-4e1e-8fad-f6176227273c	true	introspection.token.claim
c255bf09-a57b-4e1e-8fad-f6176227273c	true	userinfo.token.claim
c255bf09-a57b-4e1e-8fad-f6176227273c	updatedAt	user.attribute
c255bf09-a57b-4e1e-8fad-f6176227273c	true	id.token.claim
c255bf09-a57b-4e1e-8fad-f6176227273c	true	access.token.claim
c255bf09-a57b-4e1e-8fad-f6176227273c	updated_at	claim.name
c255bf09-a57b-4e1e-8fad-f6176227273c	long	jsonType.label
e36f8ec2-d935-4a72-805d-0481a2169964	true	introspection.token.claim
e36f8ec2-d935-4a72-805d-0481a2169964	true	userinfo.token.claim
e36f8ec2-d935-4a72-805d-0481a2169964	website	user.attribute
e36f8ec2-d935-4a72-805d-0481a2169964	true	id.token.claim
e36f8ec2-d935-4a72-805d-0481a2169964	true	access.token.claim
e36f8ec2-d935-4a72-805d-0481a2169964	website	claim.name
e36f8ec2-d935-4a72-805d-0481a2169964	String	jsonType.label
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	true	introspection.token.claim
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	true	userinfo.token.claim
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	nickname	user.attribute
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	true	id.token.claim
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	true	access.token.claim
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	nickname	claim.name
f626010d-2ae2-47d8-8bd4-fce9b1ea2348	String	jsonType.label
f858bb5a-3d35-413b-b1f4-c83aa60e5694	true	introspection.token.claim
f858bb5a-3d35-413b-b1f4-c83aa60e5694	true	userinfo.token.claim
f858bb5a-3d35-413b-b1f4-c83aa60e5694	lastName	user.attribute
f858bb5a-3d35-413b-b1f4-c83aa60e5694	true	id.token.claim
f858bb5a-3d35-413b-b1f4-c83aa60e5694	true	access.token.claim
f858bb5a-3d35-413b-b1f4-c83aa60e5694	family_name	claim.name
f858bb5a-3d35-413b-b1f4-c83aa60e5694	String	jsonType.label
11ceb1b8-08e4-4717-9828-a762ead3f41f	true	introspection.token.claim
11ceb1b8-08e4-4717-9828-a762ead3f41f	true	userinfo.token.claim
11ceb1b8-08e4-4717-9828-a762ead3f41f	email	user.attribute
11ceb1b8-08e4-4717-9828-a762ead3f41f	true	id.token.claim
11ceb1b8-08e4-4717-9828-a762ead3f41f	true	access.token.claim
11ceb1b8-08e4-4717-9828-a762ead3f41f	email	claim.name
11ceb1b8-08e4-4717-9828-a762ead3f41f	String	jsonType.label
1f4a480e-1942-421c-84c1-cdb787fa0ff6	true	introspection.token.claim
1f4a480e-1942-421c-84c1-cdb787fa0ff6	true	userinfo.token.claim
1f4a480e-1942-421c-84c1-cdb787fa0ff6	emailVerified	user.attribute
1f4a480e-1942-421c-84c1-cdb787fa0ff6	true	id.token.claim
1f4a480e-1942-421c-84c1-cdb787fa0ff6	true	access.token.claim
1f4a480e-1942-421c-84c1-cdb787fa0ff6	email_verified	claim.name
1f4a480e-1942-421c-84c1-cdb787fa0ff6	boolean	jsonType.label
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	formatted	user.attribute.formatted
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	country	user.attribute.country
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	true	introspection.token.claim
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	postal_code	user.attribute.postal_code
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	true	userinfo.token.claim
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	street	user.attribute.street
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	true	id.token.claim
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	region	user.attribute.region
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	true	access.token.claim
76d755b8-9ad0-4127-a62c-1078ac9c2cf2	locality	user.attribute.locality
a328e2aa-9800-4205-ad4a-7017afc0e72d	true	introspection.token.claim
a328e2aa-9800-4205-ad4a-7017afc0e72d	true	userinfo.token.claim
a328e2aa-9800-4205-ad4a-7017afc0e72d	phoneNumberVerified	user.attribute
a328e2aa-9800-4205-ad4a-7017afc0e72d	true	id.token.claim
a328e2aa-9800-4205-ad4a-7017afc0e72d	true	access.token.claim
a328e2aa-9800-4205-ad4a-7017afc0e72d	phone_number_verified	claim.name
a328e2aa-9800-4205-ad4a-7017afc0e72d	boolean	jsonType.label
c84a3527-1d41-497d-b197-385a63afd35b	true	introspection.token.claim
c84a3527-1d41-497d-b197-385a63afd35b	true	userinfo.token.claim
c84a3527-1d41-497d-b197-385a63afd35b	phoneNumber	user.attribute
c84a3527-1d41-497d-b197-385a63afd35b	true	id.token.claim
c84a3527-1d41-497d-b197-385a63afd35b	true	access.token.claim
c84a3527-1d41-497d-b197-385a63afd35b	phone_number	claim.name
c84a3527-1d41-497d-b197-385a63afd35b	String	jsonType.label
097a1a34-804e-43d6-b798-cd48b82b8d8f	true	introspection.token.claim
097a1a34-804e-43d6-b798-cd48b82b8d8f	true	multivalued
097a1a34-804e-43d6-b798-cd48b82b8d8f	foo	user.attribute
097a1a34-804e-43d6-b798-cd48b82b8d8f	true	access.token.claim
097a1a34-804e-43d6-b798-cd48b82b8d8f	resource_access.${client_id}.roles	claim.name
097a1a34-804e-43d6-b798-cd48b82b8d8f	String	jsonType.label
560e1866-48ce-48f1-9f18-64ba6b236373	true	introspection.token.claim
560e1866-48ce-48f1-9f18-64ba6b236373	true	multivalued
560e1866-48ce-48f1-9f18-64ba6b236373	foo	user.attribute
560e1866-48ce-48f1-9f18-64ba6b236373	true	access.token.claim
560e1866-48ce-48f1-9f18-64ba6b236373	realm_access.roles	claim.name
560e1866-48ce-48f1-9f18-64ba6b236373	String	jsonType.label
a610876a-f1bd-4d0e-ae67-a8ae9355a9bc	true	introspection.token.claim
a610876a-f1bd-4d0e-ae67-a8ae9355a9bc	true	access.token.claim
3345e7ef-b77b-4317-9fd6-ddef2aa4fb71	true	introspection.token.claim
3345e7ef-b77b-4317-9fd6-ddef2aa4fb71	true	access.token.claim
43017c08-4b16-4ddc-9d7d-14ab3644880a	true	introspection.token.claim
43017c08-4b16-4ddc-9d7d-14ab3644880a	true	multivalued
43017c08-4b16-4ddc-9d7d-14ab3644880a	foo	user.attribute
43017c08-4b16-4ddc-9d7d-14ab3644880a	true	id.token.claim
43017c08-4b16-4ddc-9d7d-14ab3644880a	true	access.token.claim
43017c08-4b16-4ddc-9d7d-14ab3644880a	groups	claim.name
43017c08-4b16-4ddc-9d7d-14ab3644880a	String	jsonType.label
627a642f-15e3-4d6d-a8d4-70b63aa86298	true	introspection.token.claim
627a642f-15e3-4d6d-a8d4-70b63aa86298	true	userinfo.token.claim
627a642f-15e3-4d6d-a8d4-70b63aa86298	username	user.attribute
627a642f-15e3-4d6d-a8d4-70b63aa86298	true	id.token.claim
627a642f-15e3-4d6d-a8d4-70b63aa86298	true	access.token.claim
627a642f-15e3-4d6d-a8d4-70b63aa86298	upn	claim.name
627a642f-15e3-4d6d-a8d4-70b63aa86298	String	jsonType.label
8875269c-c76b-468c-8af9-3faacf305f7f	true	introspection.token.claim
8875269c-c76b-468c-8af9-3faacf305f7f	true	id.token.claim
8875269c-c76b-468c-8af9-3faacf305f7f	true	access.token.claim
886ea700-2511-49da-a993-91eb4c510f75	AUTH_TIME	user.session.note
886ea700-2511-49da-a993-91eb4c510f75	true	introspection.token.claim
886ea700-2511-49da-a993-91eb4c510f75	true	id.token.claim
886ea700-2511-49da-a993-91eb4c510f75	true	access.token.claim
886ea700-2511-49da-a993-91eb4c510f75	auth_time	claim.name
886ea700-2511-49da-a993-91eb4c510f75	long	jsonType.label
b7be69d6-446e-43cc-b3b4-9b211dedf27b	true	introspection.token.claim
b7be69d6-446e-43cc-b3b4-9b211dedf27b	true	access.token.claim
760bdc5c-25f5-4350-802c-8ae3333ab4d2	false	single
760bdc5c-25f5-4350-802c-8ae3333ab4d2	Basic	attribute.nameformat
760bdc5c-25f5-4350-802c-8ae3333ab4d2	Role	attribute.name
0199c188-b331-445c-b599-aa41ab0eeabe	true	introspection.token.claim
0199c188-b331-445c-b599-aa41ab0eeabe	true	userinfo.token.claim
0199c188-b331-445c-b599-aa41ab0eeabe	gender	user.attribute
0199c188-b331-445c-b599-aa41ab0eeabe	true	id.token.claim
0199c188-b331-445c-b599-aa41ab0eeabe	true	access.token.claim
0199c188-b331-445c-b599-aa41ab0eeabe	gender	claim.name
0199c188-b331-445c-b599-aa41ab0eeabe	String	jsonType.label
1b9af1fd-a45e-4615-a420-842d55cf8767	true	introspection.token.claim
1b9af1fd-a45e-4615-a420-842d55cf8767	true	userinfo.token.claim
1b9af1fd-a45e-4615-a420-842d55cf8767	zoneinfo	user.attribute
1b9af1fd-a45e-4615-a420-842d55cf8767	true	id.token.claim
1b9af1fd-a45e-4615-a420-842d55cf8767	true	access.token.claim
1b9af1fd-a45e-4615-a420-842d55cf8767	zoneinfo	claim.name
1b9af1fd-a45e-4615-a420-842d55cf8767	String	jsonType.label
474a17c0-c927-41cc-af3d-4b29e9395937	true	introspection.token.claim
474a17c0-c927-41cc-af3d-4b29e9395937	true	userinfo.token.claim
474a17c0-c927-41cc-af3d-4b29e9395937	username	user.attribute
474a17c0-c927-41cc-af3d-4b29e9395937	true	id.token.claim
474a17c0-c927-41cc-af3d-4b29e9395937	true	access.token.claim
474a17c0-c927-41cc-af3d-4b29e9395937	preferred_username	claim.name
474a17c0-c927-41cc-af3d-4b29e9395937	String	jsonType.label
64748278-3037-4291-a454-11e403a97b9d	true	introspection.token.claim
64748278-3037-4291-a454-11e403a97b9d	true	userinfo.token.claim
64748278-3037-4291-a454-11e403a97b9d	nickname	user.attribute
64748278-3037-4291-a454-11e403a97b9d	true	id.token.claim
64748278-3037-4291-a454-11e403a97b9d	true	access.token.claim
64748278-3037-4291-a454-11e403a97b9d	nickname	claim.name
64748278-3037-4291-a454-11e403a97b9d	String	jsonType.label
65e9cb1f-08c8-4ba5-b693-aeccb1248149	true	introspection.token.claim
65e9cb1f-08c8-4ba5-b693-aeccb1248149	true	userinfo.token.claim
65e9cb1f-08c8-4ba5-b693-aeccb1248149	lastName	user.attribute
65e9cb1f-08c8-4ba5-b693-aeccb1248149	true	id.token.claim
65e9cb1f-08c8-4ba5-b693-aeccb1248149	true	access.token.claim
65e9cb1f-08c8-4ba5-b693-aeccb1248149	family_name	claim.name
65e9cb1f-08c8-4ba5-b693-aeccb1248149	String	jsonType.label
6821e6c5-304d-4efb-a369-2fa54c37b785	true	introspection.token.claim
6821e6c5-304d-4efb-a369-2fa54c37b785	true	userinfo.token.claim
6821e6c5-304d-4efb-a369-2fa54c37b785	locale	user.attribute
6821e6c5-304d-4efb-a369-2fa54c37b785	true	id.token.claim
6821e6c5-304d-4efb-a369-2fa54c37b785	true	access.token.claim
6821e6c5-304d-4efb-a369-2fa54c37b785	locale	claim.name
6821e6c5-304d-4efb-a369-2fa54c37b785	String	jsonType.label
763dbdb3-f0de-4bb5-9fe3-4a2ca3a760cd	true	introspection.token.claim
763dbdb3-f0de-4bb5-9fe3-4a2ca3a760cd	true	userinfo.token.claim
763dbdb3-f0de-4bb5-9fe3-4a2ca3a760cd	true	id.token.claim
763dbdb3-f0de-4bb5-9fe3-4a2ca3a760cd	true	access.token.claim
78b2442b-719b-443d-a254-29f22e3620fa	true	introspection.token.claim
78b2442b-719b-443d-a254-29f22e3620fa	true	userinfo.token.claim
78b2442b-719b-443d-a254-29f22e3620fa	birthdate	user.attribute
78b2442b-719b-443d-a254-29f22e3620fa	true	id.token.claim
78b2442b-719b-443d-a254-29f22e3620fa	true	access.token.claim
78b2442b-719b-443d-a254-29f22e3620fa	birthdate	claim.name
78b2442b-719b-443d-a254-29f22e3620fa	String	jsonType.label
7f221a4d-8b48-4ab1-9c93-96986f6f89be	true	introspection.token.claim
7f221a4d-8b48-4ab1-9c93-96986f6f89be	true	userinfo.token.claim
7f221a4d-8b48-4ab1-9c93-96986f6f89be	middleName	user.attribute
7f221a4d-8b48-4ab1-9c93-96986f6f89be	true	id.token.claim
7f221a4d-8b48-4ab1-9c93-96986f6f89be	true	access.token.claim
7f221a4d-8b48-4ab1-9c93-96986f6f89be	middle_name	claim.name
7f221a4d-8b48-4ab1-9c93-96986f6f89be	String	jsonType.label
8835bbd7-9588-428a-a2e0-5fdebe33c973	true	introspection.token.claim
8835bbd7-9588-428a-a2e0-5fdebe33c973	true	userinfo.token.claim
8835bbd7-9588-428a-a2e0-5fdebe33c973	website	user.attribute
8835bbd7-9588-428a-a2e0-5fdebe33c973	true	id.token.claim
8835bbd7-9588-428a-a2e0-5fdebe33c973	true	access.token.claim
8835bbd7-9588-428a-a2e0-5fdebe33c973	website	claim.name
8835bbd7-9588-428a-a2e0-5fdebe33c973	String	jsonType.label
8b49f293-79b3-496a-9b53-980b0d3ad7e2	true	introspection.token.claim
8b49f293-79b3-496a-9b53-980b0d3ad7e2	true	userinfo.token.claim
8b49f293-79b3-496a-9b53-980b0d3ad7e2	updatedAt	user.attribute
8b49f293-79b3-496a-9b53-980b0d3ad7e2	true	id.token.claim
8b49f293-79b3-496a-9b53-980b0d3ad7e2	true	access.token.claim
8b49f293-79b3-496a-9b53-980b0d3ad7e2	updated_at	claim.name
8b49f293-79b3-496a-9b53-980b0d3ad7e2	long	jsonType.label
956d7b8b-79a9-44c5-b244-8530cacb2364	true	introspection.token.claim
956d7b8b-79a9-44c5-b244-8530cacb2364	true	userinfo.token.claim
956d7b8b-79a9-44c5-b244-8530cacb2364	picture	user.attribute
956d7b8b-79a9-44c5-b244-8530cacb2364	true	id.token.claim
956d7b8b-79a9-44c5-b244-8530cacb2364	true	access.token.claim
956d7b8b-79a9-44c5-b244-8530cacb2364	picture	claim.name
956d7b8b-79a9-44c5-b244-8530cacb2364	String	jsonType.label
ab009c33-f0ae-4171-b2e1-b99589efbb8c	true	introspection.token.claim
ab009c33-f0ae-4171-b2e1-b99589efbb8c	true	userinfo.token.claim
ab009c33-f0ae-4171-b2e1-b99589efbb8c	profile	user.attribute
ab009c33-f0ae-4171-b2e1-b99589efbb8c	true	id.token.claim
ab009c33-f0ae-4171-b2e1-b99589efbb8c	true	access.token.claim
ab009c33-f0ae-4171-b2e1-b99589efbb8c	profile	claim.name
ab009c33-f0ae-4171-b2e1-b99589efbb8c	String	jsonType.label
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	true	introspection.token.claim
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	true	userinfo.token.claim
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	firstName	user.attribute
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	true	id.token.claim
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	true	access.token.claim
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	given_name	claim.name
aeb940f3-c8bb-42bc-b87b-5c1dc3015141	String	jsonType.label
2944859f-fa63-445e-a11e-7a4f2a8c0767	true	introspection.token.claim
2944859f-fa63-445e-a11e-7a4f2a8c0767	true	userinfo.token.claim
2944859f-fa63-445e-a11e-7a4f2a8c0767	emailVerified	user.attribute
2944859f-fa63-445e-a11e-7a4f2a8c0767	true	id.token.claim
2944859f-fa63-445e-a11e-7a4f2a8c0767	true	access.token.claim
2944859f-fa63-445e-a11e-7a4f2a8c0767	email_verified	claim.name
2944859f-fa63-445e-a11e-7a4f2a8c0767	boolean	jsonType.label
972d3b03-786d-45ab-bfe6-31dde3670f8b	true	introspection.token.claim
972d3b03-786d-45ab-bfe6-31dde3670f8b	true	userinfo.token.claim
972d3b03-786d-45ab-bfe6-31dde3670f8b	email	user.attribute
972d3b03-786d-45ab-bfe6-31dde3670f8b	true	id.token.claim
972d3b03-786d-45ab-bfe6-31dde3670f8b	true	access.token.claim
972d3b03-786d-45ab-bfe6-31dde3670f8b	email	claim.name
972d3b03-786d-45ab-bfe6-31dde3670f8b	String	jsonType.label
31e6351d-05d7-496a-91a5-bf21c0504e9f	formatted	user.attribute.formatted
31e6351d-05d7-496a-91a5-bf21c0504e9f	country	user.attribute.country
31e6351d-05d7-496a-91a5-bf21c0504e9f	true	introspection.token.claim
31e6351d-05d7-496a-91a5-bf21c0504e9f	postal_code	user.attribute.postal_code
31e6351d-05d7-496a-91a5-bf21c0504e9f	true	userinfo.token.claim
31e6351d-05d7-496a-91a5-bf21c0504e9f	street	user.attribute.street
31e6351d-05d7-496a-91a5-bf21c0504e9f	true	id.token.claim
31e6351d-05d7-496a-91a5-bf21c0504e9f	region	user.attribute.region
31e6351d-05d7-496a-91a5-bf21c0504e9f	true	access.token.claim
31e6351d-05d7-496a-91a5-bf21c0504e9f	locality	user.attribute.locality
679d758f-1403-4642-b6f5-1e56ed1f9510	true	introspection.token.claim
679d758f-1403-4642-b6f5-1e56ed1f9510	true	userinfo.token.claim
679d758f-1403-4642-b6f5-1e56ed1f9510	phoneNumber	user.attribute
679d758f-1403-4642-b6f5-1e56ed1f9510	true	id.token.claim
679d758f-1403-4642-b6f5-1e56ed1f9510	true	access.token.claim
679d758f-1403-4642-b6f5-1e56ed1f9510	phone_number	claim.name
679d758f-1403-4642-b6f5-1e56ed1f9510	String	jsonType.label
fdf265bd-dd96-44f4-ad42-fdddfaa572da	true	introspection.token.claim
fdf265bd-dd96-44f4-ad42-fdddfaa572da	true	userinfo.token.claim
fdf265bd-dd96-44f4-ad42-fdddfaa572da	phoneNumberVerified	user.attribute
fdf265bd-dd96-44f4-ad42-fdddfaa572da	true	id.token.claim
fdf265bd-dd96-44f4-ad42-fdddfaa572da	true	access.token.claim
fdf265bd-dd96-44f4-ad42-fdddfaa572da	phone_number_verified	claim.name
fdf265bd-dd96-44f4-ad42-fdddfaa572da	boolean	jsonType.label
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	true	introspection.token.claim
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	true	multivalued
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	foo	user.attribute
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	true	access.token.claim
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	resource_access.${client_id}.roles	claim.name
51ffb577-4f6a-4e7e-97c9-38829c6e0ebf	String	jsonType.label
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	true	introspection.token.claim
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	true	multivalued
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	foo	user.attribute
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	true	access.token.claim
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	realm_access.roles	claim.name
5fecb21c-6fb3-40e2-9ae1-ecca79a37d9f	String	jsonType.label
b8bcbd31-f534-4787-898b-d4bf6ff71180	true	introspection.token.claim
b8bcbd31-f534-4787-898b-d4bf6ff71180	true	access.token.claim
f1d1aece-44ef-4e11-b34b-712b79ec5ef7	true	introspection.token.claim
f1d1aece-44ef-4e11-b34b-712b79ec5ef7	true	access.token.claim
9a959bbc-403a-456f-88f6-b940708c4738	true	introspection.token.claim
9a959bbc-403a-456f-88f6-b940708c4738	true	multivalued
9a959bbc-403a-456f-88f6-b940708c4738	foo	user.attribute
9a959bbc-403a-456f-88f6-b940708c4738	true	id.token.claim
9a959bbc-403a-456f-88f6-b940708c4738	true	access.token.claim
9a959bbc-403a-456f-88f6-b940708c4738	groups	claim.name
9a959bbc-403a-456f-88f6-b940708c4738	String	jsonType.label
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	true	introspection.token.claim
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	true	userinfo.token.claim
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	username	user.attribute
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	true	id.token.claim
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	true	access.token.claim
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	upn	claim.name
9e64bc47-4ef0-4a84-bd16-134b6cf107c6	String	jsonType.label
83ef699d-6957-4c14-b6d6-d76d01869187	true	introspection.token.claim
83ef699d-6957-4c14-b6d6-d76d01869187	true	id.token.claim
83ef699d-6957-4c14-b6d6-d76d01869187	true	access.token.claim
6581555a-1d15-4265-9823-1fe6139e626e	AUTH_TIME	user.session.note
6581555a-1d15-4265-9823-1fe6139e626e	true	introspection.token.claim
6581555a-1d15-4265-9823-1fe6139e626e	true	id.token.claim
6581555a-1d15-4265-9823-1fe6139e626e	true	access.token.claim
6581555a-1d15-4265-9823-1fe6139e626e	auth_time	claim.name
6581555a-1d15-4265-9823-1fe6139e626e	long	jsonType.label
e7ab7861-4b32-4edb-8fd4-77607d025073	true	introspection.token.claim
e7ab7861-4b32-4edb-8fd4-77607d025073	true	access.token.claim
befced29-1dd6-4f97-b1fb-00e09edaed9f	true	introspection.token.claim
befced29-1dd6-4f97-b1fb-00e09edaed9f	true	userinfo.token.claim
befced29-1dd6-4f97-b1fb-00e09edaed9f	locale	user.attribute
befced29-1dd6-4f97-b1fb-00e09edaed9f	true	id.token.claim
befced29-1dd6-4f97-b1fb-00e09edaed9f	true	access.token.claim
befced29-1dd6-4f97-b1fb-00e09edaed9f	locale	claim.name
befced29-1dd6-4f97-b1fb-00e09edaed9f	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
679c1e80-fcc8-4163-ae01-167899dcf2c9	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d97c2598-271c-46e3-b469-eabf3377e7ca	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	16d4af84-2400-4742-968e-c80eba53c158	ce30e49c-087b-4dc7-95cf-9f88207cfd7c	7eaf02e9-a8f8-4fb6-9e0d-55b857e13229	ed15735d-45d3-4381-9de8-fc1820426100	38ddc41b-f882-4fdb-9f06-1a6e191d7987	2592000	f	900	t	f	41e596b0-40cd-453b-a303-a2c0e3d4b33b	0	f	0	0	93faad58-aefd-4fb2-802b-01b40d8ad14b
77d679c9-57ee-4dfb-843c-31bd47ea51bf	60	300	300	\N	\N	\N	t	f	0	\N	apache-realm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e2db30ea-1b1d-43b8-9a47-754b4cad55f3	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2e9164d5-a486-4c61-a0ce-db84cb083279	0cdf044a-fdd8-43be-95ed-ae78976a1fac	b391a32e-584c-451f-aa61-c051b750e0f1	5df5acb8-1cef-4226-b50a-2e960807635e	9559b9d3-c5ec-4cf6-84f5-6ffafb280727	2592000	f	900	t	f	8559f02e-7d49-4427-875d-a6707e7c07e9	0	f	0	0	9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	679c1e80-fcc8-4163-ae01-167899dcf2c9	
_browser_header.xContentTypeOptions	679c1e80-fcc8-4163-ae01-167899dcf2c9	nosniff
_browser_header.referrerPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	no-referrer
_browser_header.xRobotsTag	679c1e80-fcc8-4163-ae01-167899dcf2c9	none
_browser_header.xFrameOptions	679c1e80-fcc8-4163-ae01-167899dcf2c9	SAMEORIGIN
_browser_header.contentSecurityPolicy	679c1e80-fcc8-4163-ae01-167899dcf2c9	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	679c1e80-fcc8-4163-ae01-167899dcf2c9	1; mode=block
_browser_header.strictTransportSecurity	679c1e80-fcc8-4163-ae01-167899dcf2c9	max-age=31536000; includeSubDomains
bruteForceProtected	679c1e80-fcc8-4163-ae01-167899dcf2c9	false
permanentLockout	679c1e80-fcc8-4163-ae01-167899dcf2c9	false
maxTemporaryLockouts	679c1e80-fcc8-4163-ae01-167899dcf2c9	0
maxFailureWaitSeconds	679c1e80-fcc8-4163-ae01-167899dcf2c9	900
minimumQuickLoginWaitSeconds	679c1e80-fcc8-4163-ae01-167899dcf2c9	60
waitIncrementSeconds	679c1e80-fcc8-4163-ae01-167899dcf2c9	60
quickLoginCheckMilliSeconds	679c1e80-fcc8-4163-ae01-167899dcf2c9	1000
maxDeltaTimeSeconds	679c1e80-fcc8-4163-ae01-167899dcf2c9	43200
failureFactor	679c1e80-fcc8-4163-ae01-167899dcf2c9	30
realmReusableOtpCode	679c1e80-fcc8-4163-ae01-167899dcf2c9	false
firstBrokerLoginFlowId	679c1e80-fcc8-4163-ae01-167899dcf2c9	0eb63bf7-69a0-498d-9822-3558f0ef30cc
displayName	679c1e80-fcc8-4163-ae01-167899dcf2c9	Keycloak
displayNameHtml	679c1e80-fcc8-4163-ae01-167899dcf2c9	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	679c1e80-fcc8-4163-ae01-167899dcf2c9	RS256
offlineSessionMaxLifespanEnabled	679c1e80-fcc8-4163-ae01-167899dcf2c9	false
offlineSessionMaxLifespan	679c1e80-fcc8-4163-ae01-167899dcf2c9	5184000
_browser_header.contentSecurityPolicyReportOnly	77d679c9-57ee-4dfb-843c-31bd47ea51bf	
_browser_header.xContentTypeOptions	77d679c9-57ee-4dfb-843c-31bd47ea51bf	nosniff
_browser_header.referrerPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	no-referrer
_browser_header.xRobotsTag	77d679c9-57ee-4dfb-843c-31bd47ea51bf	none
_browser_header.xFrameOptions	77d679c9-57ee-4dfb-843c-31bd47ea51bf	SAMEORIGIN
_browser_header.contentSecurityPolicy	77d679c9-57ee-4dfb-843c-31bd47ea51bf	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	77d679c9-57ee-4dfb-843c-31bd47ea51bf	1; mode=block
_browser_header.strictTransportSecurity	77d679c9-57ee-4dfb-843c-31bd47ea51bf	max-age=31536000; includeSubDomains
bruteForceProtected	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
permanentLockout	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
maxTemporaryLockouts	77d679c9-57ee-4dfb-843c-31bd47ea51bf	0
maxFailureWaitSeconds	77d679c9-57ee-4dfb-843c-31bd47ea51bf	900
minimumQuickLoginWaitSeconds	77d679c9-57ee-4dfb-843c-31bd47ea51bf	60
waitIncrementSeconds	77d679c9-57ee-4dfb-843c-31bd47ea51bf	60
quickLoginCheckMilliSeconds	77d679c9-57ee-4dfb-843c-31bd47ea51bf	1000
maxDeltaTimeSeconds	77d679c9-57ee-4dfb-843c-31bd47ea51bf	43200
failureFactor	77d679c9-57ee-4dfb-843c-31bd47ea51bf	30
realmReusableOtpCode	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
defaultSignatureAlgorithm	77d679c9-57ee-4dfb-843c-31bd47ea51bf	RS256
offlineSessionMaxLifespanEnabled	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
offlineSessionMaxLifespan	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5184000
actionTokenGeneratedByAdminLifespan	77d679c9-57ee-4dfb-843c-31bd47ea51bf	43200
actionTokenGeneratedByUserLifespan	77d679c9-57ee-4dfb-843c-31bd47ea51bf	300
oauth2DeviceCodeLifespan	77d679c9-57ee-4dfb-843c-31bd47ea51bf	600
oauth2DevicePollingInterval	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5
webAuthnPolicyRpEntityName	77d679c9-57ee-4dfb-843c-31bd47ea51bf	keycloak
webAuthnPolicySignatureAlgorithms	77d679c9-57ee-4dfb-843c-31bd47ea51bf	ES256
webAuthnPolicyRpId	77d679c9-57ee-4dfb-843c-31bd47ea51bf	
webAuthnPolicyAttestationConveyancePreference	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyAuthenticatorAttachment	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyRequireResidentKey	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyUserVerificationRequirement	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyCreateTimeout	77d679c9-57ee-4dfb-843c-31bd47ea51bf	0
webAuthnPolicyAvoidSameAuthenticatorRegister	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
webAuthnPolicyRpEntityNamePasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	ES256
webAuthnPolicyRpIdPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	
webAuthnPolicyAttestationConveyancePreferencePasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyRequireResidentKeyPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	not specified
webAuthnPolicyCreateTimeoutPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	false
cibaBackchannelTokenDeliveryMode	77d679c9-57ee-4dfb-843c-31bd47ea51bf	poll
cibaExpiresIn	77d679c9-57ee-4dfb-843c-31bd47ea51bf	120
cibaInterval	77d679c9-57ee-4dfb-843c-31bd47ea51bf	5
cibaAuthRequestedUserHint	77d679c9-57ee-4dfb-843c-31bd47ea51bf	login_hint
parRequestUriLifespan	77d679c9-57ee-4dfb-843c-31bd47ea51bf	60
firstBrokerLoginFlowId	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f83554d6-f28c-40d4-b28d-8fa1b4cf596f
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
679c1e80-fcc8-4163-ae01-167899dcf2c9	jboss-logging
77d679c9-57ee-4dfb-843c-31bd47ea51bf	jboss-logging
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
password	password	t	t	679c1e80-fcc8-4163-ae01-167899dcf2c9
password	password	t	t	77d679c9-57ee-4dfb-843c-31bd47ea51bf
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
b3ec984c-ec1d-4af6-b0af-2e6228ce66d4	/realms/master/account/*
b75135d3-4010-4750-8385-8608371afc8c	/realms/master/account/*
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	/admin/master/console/*
e580c1a3-095f-4554-8d95-c14c455d9fa3	/realms/apache-realm/account/*
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	/realms/apache-realm/account/*
4fdc51f0-2572-4794-ad42-cddc24bce561	/admin/apache-realm/console/*
fc64e80b-6c30-4749-8e19-18f12ff697ff	/*
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
5c897213-4f70-4dbd-a5c9-8e3cfaa2061f	VERIFY_EMAIL	Verify Email	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	VERIFY_EMAIL	50
c7e72479-c644-4cc5-b676-72cd587e1f0d	UPDATE_PROFILE	Update Profile	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	UPDATE_PROFILE	40
7399da38-55d8-4c78-a49b-d0cb2107ef8a	CONFIGURE_TOTP	Configure OTP	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	CONFIGURE_TOTP	10
b6fb97a3-a8fb-4a3a-b39b-7cb168cc3a46	UPDATE_PASSWORD	Update Password	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	UPDATE_PASSWORD	30
892a7389-7e80-47fd-900f-41f4612270f6	TERMS_AND_CONDITIONS	Terms and Conditions	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	f	TERMS_AND_CONDITIONS	20
06317a3d-92e3-4008-9451-cfc20551c363	delete_account	Delete Account	679c1e80-fcc8-4163-ae01-167899dcf2c9	f	f	delete_account	60
16deab94-a86f-42a0-b13b-a0a5e985d682	delete_credential	Delete Credential	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	delete_credential	100
94c483d8-e693-4faa-89e2-c504c8471a51	update_user_locale	Update User Locale	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	update_user_locale	1000
fce12de1-6773-41fa-a046-27056bb80746	webauthn-register	Webauthn Register	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	webauthn-register	70
5fbff796-2c78-4a8d-8ce3-afb045e0a274	webauthn-register-passwordless	Webauthn Register Passwordless	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	webauthn-register-passwordless	80
ca91738b-7aa2-4c8d-bfa0-3709c5332f4a	VERIFY_PROFILE	Verify Profile	679c1e80-fcc8-4163-ae01-167899dcf2c9	t	f	VERIFY_PROFILE	90
8fe3fc8f-d10f-49d1-85f2-fc5453a63b6b	VERIFY_EMAIL	Verify Email	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	VERIFY_EMAIL	50
fe5dd63f-ece1-402f-a573-cbb784531f56	UPDATE_PROFILE	Update Profile	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	UPDATE_PROFILE	40
d938af0b-9a37-4db0-9150-26efe86d6a5e	CONFIGURE_TOTP	Configure OTP	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	CONFIGURE_TOTP	10
5ea76272-d8ae-4f0e-a2ee-fb3bfa45e4cf	UPDATE_PASSWORD	Update Password	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	UPDATE_PASSWORD	30
f2909305-8471-4e8c-836e-9996f1d89e50	TERMS_AND_CONDITIONS	Terms and Conditions	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f	f	TERMS_AND_CONDITIONS	20
337f626f-baf8-4ea9-9743-b18e26977e70	delete_account	Delete Account	77d679c9-57ee-4dfb-843c-31bd47ea51bf	f	f	delete_account	60
0ada3cec-04c3-4b03-b935-fadf556a851a	delete_credential	Delete Credential	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	delete_credential	100
3a3dc2bc-169e-4f91-b2a4-b1887509bbca	update_user_locale	Update User Locale	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	update_user_locale	1000
86dcf984-80be-4cd5-9763-ebde536a3c49	webauthn-register	Webauthn Register	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	webauthn-register	70
e4b4ac3b-47bf-46de-8ea6-6f45d59425ed	webauthn-register-passwordless	Webauthn Register Passwordless	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	webauthn-register-passwordless	80
2e66d86a-2621-4dfe-88f1-b533398d12b7	VERIFY_PROFILE	Verify Profile	77d679c9-57ee-4dfb-843c-31bd47ea51bf	t	f	VERIFY_PROFILE	90
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
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
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
b75135d3-4010-4750-8385-8608371afc8c	1f69fe59-c850-4bae-997f-ea92bc31db5d
b75135d3-4010-4750-8385-8608371afc8c	ed0e3ef7-628f-44b6-9cba-104ffffb02ca
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	cdff88b4-d730-49da-9e25-479f420c75c0
7221aedb-3ea8-48b9-9d73-f89d0ac87c11	10616377-2d45-47cb-8dda-11f4ad03e966
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
67f2291e-b5a0-4e9f-99e4-0703c1c56968	\N	ccccd18c-ecb8-444c-ae04-8ee047c1f30e	f	t	\N	\N	\N	679c1e80-fcc8-4163-ae01-167899dcf2c9	admin	1719996944751	\N	0
00d7423f-1185-450e-a1b3-c300a5d32b8c	\N	daea70f2-14d4-4100-8fde-a21c34ded3ad	f	t	\N	\N	\N	77d679c9-57ee-4dfb-843c-31bd47ea51bf	admin	1719997054117	\N	0
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
00d7423f-1185-450e-a1b3-c300a5d32b8c	UPDATE_PASSWORD
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
93faad58-aefd-4fb2-802b-01b40d8ad14b	67f2291e-b5a0-4e9f-99e4-0703c1c56968
ffb2bae7-c728-45a7-ad88-4c8e9433c823	67f2291e-b5a0-4e9f-99e4-0703c1c56968
6ad7c93d-05c9-4180-a7f0-643934cf7cec	67f2291e-b5a0-4e9f-99e4-0703c1c56968
24bdc955-ad24-4f7a-8be0-7f5af6856584	67f2291e-b5a0-4e9f-99e4-0703c1c56968
06285f1c-b6ce-488f-8015-88885dc8d034	67f2291e-b5a0-4e9f-99e4-0703c1c56968
eed0ea51-a0ca-41bf-9b85-8dce5504cbd9	67f2291e-b5a0-4e9f-99e4-0703c1c56968
de1bbea7-ffbb-40b4-b2d0-abc1b19efe1f	67f2291e-b5a0-4e9f-99e4-0703c1c56968
9fcc1a0f-ff6e-48ed-9cf5-c507a0b60a58	67f2291e-b5a0-4e9f-99e4-0703c1c56968
1714509b-9ecf-488a-b5de-44025834be19	67f2291e-b5a0-4e9f-99e4-0703c1c56968
a0bd4592-432f-4e3c-99ea-c5fd952a73f6	67f2291e-b5a0-4e9f-99e4-0703c1c56968
a3543b8b-69ea-478e-85f8-6e9616e1717d	67f2291e-b5a0-4e9f-99e4-0703c1c56968
c9750c93-d2c2-4b88-bad1-0fd17b8541cb	67f2291e-b5a0-4e9f-99e4-0703c1c56968
b172f851-494e-402c-a82a-be7738aaf9d6	67f2291e-b5a0-4e9f-99e4-0703c1c56968
57b4ab09-f0dd-40b1-99e0-a2c06c0493eb	67f2291e-b5a0-4e9f-99e4-0703c1c56968
51f6bda5-e040-41da-8ca6-bd4568483d72	67f2291e-b5a0-4e9f-99e4-0703c1c56968
e090bc6e-978e-4c0f-a0e9-0997c9ea6a02	67f2291e-b5a0-4e9f-99e4-0703c1c56968
04893b85-c16d-4f5f-82fc-ac1b1d509070	67f2291e-b5a0-4e9f-99e4-0703c1c56968
743adcb5-188e-4741-b6af-c05534c900f7	67f2291e-b5a0-4e9f-99e4-0703c1c56968
10c17ea3-cda3-420d-84d3-c37d95b58a11	67f2291e-b5a0-4e9f-99e4-0703c1c56968
9ace5aa7-76c3-42e0-a5fb-a5e9db09a2ad	00d7423f-1185-450e-a1b3-c300a5d32b8c
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
7a0dd0ed-bcb1-4faa-b894-ffbfabae80d3	+
4fdc51f0-2572-4794-ad42-cddc24bce561	+
fc64e80b-6c30-4749-8e19-18f12ff697ff	/*
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

