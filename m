Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B83D7D9C
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629139; cv=fail; b=UajI3yYZAMJlS4+7YpLSNpFSoXKUclAUEVETfgBZ41uf4qghxorLKg+6m363S9hiPGy6lN/1woeOdTLmT5b0ZpmqpUrvUly3xE9Z+RGs8OnFbXkB08ne7Agc7/whynu5nbGMyvlYUDfA5Ao2/m0al49o0Wmm3UXgyEN6l57m10o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629139; c=relaxed/simple;
	bh=1DlfxEt9ldfynIyEvosb+smGwlUIrpiy8VKvwh4S3gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kaskSkBRR/uBu5/Q7n0HGVUc9m1nLvd6zeHvnR/YcE7ODqrXM8RMROpPVYd181RO7IRTXHBKK+GCoDel6AYKPRiW8AZakd0NFWh+1hGQTNNTnCIC+24weVKb/3kRPYkklc9LKEbdJIe/IKpvVOndCqkZqwtl4XBpCkOogwi8Xf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c2UDZ1qA; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c2UDZ1qA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ1Czs7IsHy7aOWeJEMXVjHLrR7fHV1LQQ5khBoBpH/VdjraBSpJB2PRuxwNqPmjP2TWUrVRxfwLp8QwaJKQuJcAUKLp3OUbYzXyK1iUOl/6gBgSTM3Y0hlPxoVZUVzHbIC2DpCTilrrJ1QmYKonNiMxT8l0welPe3clVtQNHAt0inj0DwHziq7jKYCamyWwjQno3stZbdelb/LhwHUgB3viBeiucM+seYO4IFEcvLoql2YAoJ71GL1UqlGc63G7SNChS9MUzub6/7gBORTyE9WmhElKcBh29sY9vziMBnouLvgUjRysN24EAK2bVsJIufri/dsiAy9v62Mo0QF3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3YRbfMcXytxVFrxjZoc+9zc5SCHw1UlTmnDpy7+noI=;
 b=pdMqS7N2Rdu+K/2XUOKNaOJLnBMsjMZ9OxYQkfqV/KWc7cI3EraJfDS5/qHAtc7SQxR1cVYRxeORj6c8YU4/kZoNlkm6Z0f0OQhP0BtqCI+pJozDViY6/6T4n2O8OK9InnEsWOzO2v71cOqIcUZ03EiDmKFtdeW5rL/4NG3ORV7zyS1hYmZ8AOgBWmiPxOrxBlZQuXANuTpJ+fTdFa0gKnpo1iSSUR/rg/vsplA3PfSSlsRxO02zVTWzb3PvjPAGO2p1eNgx6FyLjMWFG503IVYICnpV3443eD3vZ8Hbtkw9Cm9LlTeWkwRJI0dkTye440jRn71z15Hca5nLKaDbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3YRbfMcXytxVFrxjZoc+9zc5SCHw1UlTmnDpy7+noI=;
 b=c2UDZ1qAvN5JswSjUo3rA+2jotIunXsHiuqeeVgqxf2qG2G0sSzYaAto+gBe9d9tt9wDZVt9fw2tF1gZm54+TlHBP9bjYeb7g6EgjnRcDNDcpbY6Cx+jQJuQu5/fQIAvcqf2ZFsm4T7Wct4916a7ftQpIrKSND1HStOvib16G1klVNrgWapZWrrSwhPko0FmceSCGF4EDn4726iMEC5pKxgfDMqkDMdrrCZB+zsn2/Wxx2ysEej5jLfnAeVvmEJZzEavB1Df+E5H5WZ1tUaBgYTFAPHLIfqd7FZgq+YwjZtRqQ5lDni824KL1i7axVQUn/iiwAlXfSdzd/+YAOhUIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:32:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 20:32:09 +0000
Date: Thu, 9 Jul 2026 22:32:00 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sched_ext: Fix bpf_link leak on early return
 in prog_run
Message-ID: <alAFQFupPov3YxMX@gpd4>
References: <20260709100340.706670-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100340.706670-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI2P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c73538-1ecf-459e-7b50-08deddf9267e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	HlCriry36JYQ+ZCSx1iJUoeS/GwHWRqiyywsNN+hYqZ61LynWt7irRiHBTySdwEe+51qqsjT7Eccb1gwL+vH1Klyc3KFHNGdKqzfTAUIl1YxKQpAD8Bh4EJ6nrtVpMXTxPCnyM5D4sPto9Bwcj7KvyDGgYNymE/1GYDizFufhlKbEtw/10UNzmCmfHi6f18Sla4XoIaiVvhVaHNYdSosw2WEyaUXZovZHXEq6Fg3QuoVFXVXKm48Swln/rjgk5cgK6en/Ro7qGhdVduI/y9CkCQba9DC4sJ2nzF7+aJBKBevMcu/FvG8r6ZiGr24/6ngFQUpTsJ3PRfDB1r4cmPo3dWP7bmndMVjcOvPPLYq9EptJzjChOkGFSYbD6ijYwZLDFiqlBzmq/fCZdI3SnDyTabVb2JkOk/90JljLyVtMQAFXyZcZMcHrtZA3/AX0fDsv71lWcdbxkl0s3vBPflVdiQx9XwcWuJi48roWhcJF5iaKNTz8WsgAxKFqrXYJXOYS3VLLp6wcyGL9QDvCp+WCh8JE+ezE3G5OYGpt48xlheT2VJDIwiz/CcshA0WxEgN5c8YLa8RubTRzHAufEHYwIWS3v1KMyYeA3Mp2jB2THFR3XQWZmir607dh+hVCFbfSKR+AHSadesKzPk68RCqoTqg4GMVpSJZGWeYUzj6/wE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBdBL9LSq9fJGP7cRI3B9nWPZoCDtgf9Em8MkXXaCdUtqg1Iq6NkUsMYx9LQ?=
 =?us-ascii?Q?PQbNIMYSWO6eaCwZ4DwL5Y2j8QLvFXuMpD5BnMmLMiv8gOrADVhtiuQZyqzm?=
 =?us-ascii?Q?IeGXzPhGl7nBxcxVTcMHbzqJryNGqWPnAZTlehHozyOuHOdhkQjv6/b1EF5G?=
 =?us-ascii?Q?WgtNdpfrwpqnT4dqmExmpB8yi+UIQ9d6ty8XJ2tjeTB2bYCeWqMCGwIsbQCx?=
 =?us-ascii?Q?frCnwHITd8+DDWerKFjjQPx3jXa/BOlnRhoIhLzk8DbEat2H/pn3tE3yYiHu?=
 =?us-ascii?Q?fotBe4ettLueVA3dGB12A1rQ39VmzGu/4d5um0agKdvv9NDlWCC9kdkgcmWu?=
 =?us-ascii?Q?8KwBQkzTCXXxKgXXzg6z7bEQMTZJDwH6ZFGtAETelw7Ra98BCUFL0F27LfQY?=
 =?us-ascii?Q?fFbB5ceJoR8yPrpHDbsIBxqoJdrR/W9A4QP5VMgzc+YqlAoNl+pBNYnSgK3E?=
 =?us-ascii?Q?85qjRus+SdlXTT2zLSKVY1M9fV4iEhjqGTipECa8H1KHEKQAIVwBJ38nLjy6?=
 =?us-ascii?Q?FFRrc8PrGLJQsYgVqABqNNuKEmyvWAFyQWPCzGBtMpKaBNq0luVh1OeK7W78?=
 =?us-ascii?Q?P/rvSAgY3Plxx8ZqLvAD5+WHXzYknktEky/YT3gC4cZZr1e9ffJL07VrUiR9?=
 =?us-ascii?Q?la9bLvmrBHDxVq3d7m9nuRJ9ncAX6qCASVdEVxa42zqFXWIn/T+bkX6ic7nz?=
 =?us-ascii?Q?J4yYktXpPvNFEba7MpvlF3RPj/xLudvJLRaWCtfl+Tgsm+URjvWCHDtcyzAE?=
 =?us-ascii?Q?aILkK06OGs6sOVXgxiQOO22o3FORHGUDcvGwYcVFyBMPubXPdlJdVLtrI3B1?=
 =?us-ascii?Q?lva3zWbePB4NS17vxMtQNBpxElOaTyHldwX0ZafwmQfdV/XuNWkGmvvq7/cF?=
 =?us-ascii?Q?r+579IY1MXD9xOdPAJ/TCk5bj4f8+0vhwrtgwnSXI8kIBf6aYEvF/IFm6n5d?=
 =?us-ascii?Q?/egZOzVdxV96zEg9VfI2ROAsgXnZkG2ji/wYH9ir4uVD0xKKbxS+rmbvvdjA?=
 =?us-ascii?Q?3yNJxFmSehWJrjvBf+ikOnPRIft4jTT9BaFLnV+beyPHB5tgkSy+HoaOjF6H?=
 =?us-ascii?Q?Rs1t/+0OyQO1AoynfrwD83Zh0Zvz95oiGtEYk09aC719DG354rfDSQOQbPd2?=
 =?us-ascii?Q?/4bVCswLV9FSJy3AjOulJjOHke8QIaIjlsV00jE1Qs3P7XE3zIdkpGCWwxV5?=
 =?us-ascii?Q?DzABq2nxcXNGli+9dJvSS+nZsLm+N5+lU127vuy0bN07FRNVE0R5g/tHXfzo?=
 =?us-ascii?Q?+T3zMa+C37otNJJc8IjouLSJtr7ebsMMvB6jbmaIp7mMUUSSkr5VijXluagS?=
 =?us-ascii?Q?NnXg1SQltcr3uj9n7zExmiABeU1TXG49BBV6SbBpB86T0lu6bQr2fyW9mvN2?=
 =?us-ascii?Q?IAxBZM6m5Uz4mRZtqWd1iNOzQm+07ZQGYTvDsPMeBPZWdW1uafo3msjYFTeT?=
 =?us-ascii?Q?6XlYfHpVJiriBXJvm8w96r9wbBq7ljOoDXMTMOziIXRTi5oSykkSrBIm53Gk?=
 =?us-ascii?Q?lpJaP3WnCXJZh9Uu48ZAWjDgUNjPkYHhs4G70uffttnFDeV0WrG675F3RCpc?=
 =?us-ascii?Q?fo9bg4425j0TFKvPCZu2CXP3VoTTlTKZbm+lFkziNcWOfm9aCpPiBgSowREv?=
 =?us-ascii?Q?DCg7heWIAYCpNoUUrttrHSpYzaVXEqxEdPLhM6Vud7S9a+t+UMkGKF6LG5XC?=
 =?us-ascii?Q?BS3RxZ9xpJfPbxOx3Hq5GTalLhztuciyQtyl+Wsw4jcXy5nlqhcQ56xy5xsE?=
 =?us-ascii?Q?HQKNw7VLoQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c73538-1ecf-459e-7b50-08deddf9267e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:32:09.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcsin4M/ENa0osgesv0rA6M9HUbrTkuX5N8lytKmIb7H5oRejdp+XAMEMjeOVuQptKOQwvY1DYQTSW6afa7GnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079

Hi Liang,

On Thu, Jul 09, 2026 at 06:03:40PM +0800, luoliang@kylinos.cn wrote:
> From: Liang Luo <luoliang@kylinos.cn>
> 
> In prog_run's run(), the bpf_link is attached early but only destroyed
> on the success path. The three SCX_EQ assertions between attach and
> destroy expand to a direct 'return SCX_TEST_FAIL', so if any of them
> triggers, bpf_link__destroy() is never reached and the BPF scheduler
> stays loaded. All subsequent tests then fail to attach because SCX is
> not in the DISABLED state.
> 
> Convert those assertions to explicit checks that jump to a unified
> 'out' label which always runs the cleanup, matching the pattern used
> in cyclic_kick_wait.c.
> 
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>

We could also add (optionally):

Fixes: a5db7817af78 ("sched_ext: Add selftests")

Other than that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/testing/selftests/sched_ext/prog_run.c | 34 +++++++++++++++-----
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched_ext/prog_run.c b/tools/testing/selftests/sched_ext/prog_run.c
> index 05974820ca69..1129ec2aaddc 100644
> --- a/tools/testing/selftests/sched_ext/prog_run.c
> +++ b/tools/testing/selftests/sched_ext/prog_run.c
> @@ -28,7 +28,8 @@ static enum scx_test_status setup(void **ctx)
>  static enum scx_test_status run(void *ctx)
>  {
>  	struct prog_run *skel = ctx;
> -	struct bpf_link *link;
> +	struct bpf_link *link = NULL;
> +	enum scx_test_status status = SCX_TEST_PASS;
>  	int prog_fd, err = 0;
>  
>  	prog_fd = bpf_program__fd(skel->progs.prog_run_syscall);
> @@ -42,23 +43,40 @@ static enum scx_test_status run(void *ctx)
>  	link = bpf_map__attach_struct_ops(skel->maps.prog_run_ops);
>  	if (!link) {
>  		SCX_ERR("Failed to attach scheduler");
> -		close(prog_fd);
> -		return SCX_TEST_FAIL;
> +		status = SCX_TEST_FAIL;
> +		goto out;
>  	}
>  
>  	err = bpf_prog_test_run_opts(prog_fd, &topts);
> -	SCX_EQ(err, 0);
> +	if (err) {
> +		SCX_ERR("BPF_PROG_RUN failed (%d)", err);
> +		status = SCX_TEST_FAIL;
> +		goto out;
> +	}
>  
>  	/* Assumes uei.kind is written last */
>  	while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
>  		sched_yield();
>  
> -	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
> -	SCX_EQ(skel->data->uei.exit_code, 0xdeadbeef);
> +	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_UNREG_BPF)) {
> +		SCX_ERR("Unexpected exit kind: %llu",
> +			(unsigned long long)skel->data->uei.kind);
> +		status = SCX_TEST_FAIL;
> +		goto out;
> +	}
> +	if (skel->data->uei.exit_code != 0xdeadbeef) {
> +		SCX_ERR("Unexpected exit code: %lld",
> +			(long long)skel->data->uei.exit_code);
> +		status = SCX_TEST_FAIL;
> +		goto out;
> +	}
> +
> +out:
>  	close(prog_fd);
> -	bpf_link__destroy(link);
> +	if (link)
> +		bpf_link__destroy(link);
>  
> -	return SCX_TEST_PASS;
> +	return status;
>  }
>  
>  static void cleanup(void *ctx)
> -- 
> 2.43.0
> 
