Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AD31770E
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614898; cv=fail; b=u3E68c5gFP7AAGjPlpeB6kT25fX1FU7apm6XU9ot5owomA+o7S8rKASdWc8lbawEix2dthBcNEBRWsD+Mdz6B01usM4EcI1+EDfLhJlY2teaN6jGK/uitlCuytei+WgJ35XnOEx85ooE1W+Mu0krEtOlqFZwxofnzYarJwQD1TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614898; c=relaxed/simple;
	bh=kxwNX169E+r8r+n7SZumreQtEGwIZpvbsEPXpp3yRLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5tCTuEmc0Ubp5+Y728B2TIZr7YaRw1P6qX803yWf88xMKm62GcvB0zl0Ai+iNr9QSMs0Vvl65oV/4iOtVC74ArUPjYnXIbn/C24IIo94IHBx1gNgTQnx2wRlx5xyALoPtzEnGKl2Gan9loUkBO8lDOZeQzLpMFKCpjm2oZWuCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qaYtSB8s; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qaYtSB8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kG5s59LlffrgxkUD2U6C8ZHVabI5cR76EuIYL0p9MaNcOuYzRcGJwXWMNhq5t59FaN3rT0KvcxYOpNce7TuqZvNHe9GUFOnX4mWnVKw9ieFleZEI+wbAqHlp81Nkx9coAC6vfaSLDkAQwm5dfaAbIbVb0rFRW4RqevH0yi4q7iu09YyNxRGLacGjk14YLSt+S3HI/RTA8fSMTMmMA1oxOmJNh1mJQI3ywhH8bon/aRFcW1UmsNEZs3u/olwv1YJuT4H+4SqVr4vilzHklxZm93BaaHTBxfWZu4rJ5g2PcKZQHeHIO8vue+Lo1NDNr8F1RwFUvVKzmxYC6x7WvT29eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI87LuPgk0JU/i20c0SOzPV0n1F3P1YD4SollwfWo+E=;
 b=GVvdg9S197Itks7mIgipqswhOJd8cPsGqKyuL8QVs4RhYuqdFXSZvZuHfRA+YZjupjKZJa3K1g5r39nYqs6Mk4hYqzcxcFFvobFxaVQx8ex3Mfvzz/J4uVGx1eHnDwQ2vtUY0jOHAXQTif/jqTGBpdn3QmH+PpsQjzESAMlj57r+8GK7PKEcyDWUMOzyDSU3hmeg2B1HTtzEPyB2c/RyIpAlWIDupwDY6LlvljYco7c8P9mrBOG+SKOYG1FE8GxC6MW/BEiEZYhmjndW0D5RBmM7p75w9p5Pqoje0QmEqrfklbAbViWs2FWT7D4wcrXUier0/jpQ9GN2ryvJzeN9vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI87LuPgk0JU/i20c0SOzPV0n1F3P1YD4SollwfWo+E=;
 b=qaYtSB8siEDspAwSjiaBz/Rf9Km4sSCQAP5X5VA0rOSE+cA+1+yrw88M2Wx2+U63bD73gDg8z+JOoWUwN4FL2JGvPE1rHCo5mQqEvGaCV9QT983cx3w4WjR3FPpM30OpKhBl1qQS7LPC+ZhmGf7eMGdfF4JwCYz5r800uRCYYhvYvVbl9nGRuj/Bj0KO1rSTPRoSzX4EZQHFpHuBtANCAXwpwhfHyCUd0zzvKmqIO0fL+FupMvN3iCHu6/eBYFowfdQmG2ahbEPPVnQ4a5eG8C0OEBDzmdss+sbdKImE1MqfYrsa5QQ6g+FLtVNEEe8C2bzYNRLBLo/1KfD9wTEIgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:08:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:08:14 +0000
Date: Tue, 23 Sep 2025 10:08:08 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/7] sched_ext: Add SCX_EFLAG_INITIALIZED to indicate
 successful ops.init()
Message-ID: <aNJVaCvbUoDsMsJJ@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-5-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-5-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6318ad-3c6b-4ee2-a42f-08ddfa78582c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25XwV2AfGKgi57TG4ZlWFUxEPaD4+t5CEB0mNS39T1Bc7vRIgbNMAh0x0DVc?=
 =?us-ascii?Q?qYmT66M+UvWfzyCCJRJn0OXot/kdat3qF3j0sGFPMkTGOJuHArogPBqJS1IC?=
 =?us-ascii?Q?ozRAi3kWghneKwLic3n1CSAiBVoqcwFqxMAuPuJvHUPWomLE7mRwe/BaZncS?=
 =?us-ascii?Q?vgZU1e24/3qGBwec2Lmjl/KoBWsaAxVZcKqryNF43vNZsnS4ipUOBNStPh95?=
 =?us-ascii?Q?3EzxDAiJ15V9AFRUJwErygfhOa4r/gmwM9dhOMaCzTZfJxE8OLOkk6U+r1oB?=
 =?us-ascii?Q?tYxCi7UkH4CcCGztH0sU3Ufap3rUtFZJzXSXFxwWl8+unGNUUK27aBCaVDAk?=
 =?us-ascii?Q?r110fjDW1Rlmi6g4vCDEveOnazNoxD4xIJkTUIRBd5gl95PNops6L9wMl4Qc?=
 =?us-ascii?Q?sP85wYV9Hmzx0uMwlm9bE7z+DkYzmQL17dmxTtEpelF446PE9ZbA8UXdgbkq?=
 =?us-ascii?Q?1xWf2/9m8aojJKODdHFj4ppsMBS84dMvyMm9HJZkp9qy4SPfB22v9Zb0fKa5?=
 =?us-ascii?Q?/fSX2OSD84VoWVRrUn3IqjhfOgY/89840HN0GWRnIB4RcAjtx82FpQYJ8in2?=
 =?us-ascii?Q?K86qmuuw5DUMdmLuuh3mku/sxTH1W07QFyrbpbX7+REcZIUqFyGXPr8etS2B?=
 =?us-ascii?Q?6LFgMbpqoCNP+SffuuQZBQCq2uIpJWanICGcwXNmUCRza9D2yEJ44+hMBmvN?=
 =?us-ascii?Q?3PszHDxljxwaN4Al9GWmZBpHCH2IkWY/44FdUyAhiyH53BC9SCJ2F8BWTLcr?=
 =?us-ascii?Q?LiNm44cQf1nx5zmK2Os8fxsEr5QHjdVHCDpodtAiz0SqOnp8YpIowsf8+fBf?=
 =?us-ascii?Q?3Q+yjQAu1QeuZMDRn6D1thy67MO7zGhIBrq/TZ/G51h+n3QoRUh1lzOIOyBA?=
 =?us-ascii?Q?+6gcwLF1GdY9e/DWij3WcCXytizmCqsO2sHD32ZmnhMJIY8gWT64VDoozomI?=
 =?us-ascii?Q?vmEJegjlMmxFV3/T+gMIRboWYQ7K9nYWbEpGq8/pNujoPf3iK8ww6hK/K9zC?=
 =?us-ascii?Q?310Be4+hlHRYFWcRp0DVuddyT/7oIqm6JhhRzv4dmg44Uf4oxbHtWvgEjgV1?=
 =?us-ascii?Q?L0pN4CM2FJr7vWfQ7CaHBgeey4ejUXbQl+el3RnXdEihbpkME8TcEp4P4Em2?=
 =?us-ascii?Q?3d65U82on4tGwhQFk4l2d9jrgJSHOCSIBpKD7lolEQIepqPC9Dx30tpX1RYM?=
 =?us-ascii?Q?zVkSWS8UChpGeZoVHETf/YTy56PCvAl6bq7JVtCtExBgPw3o6XsUJ0uiIIVM?=
 =?us-ascii?Q?RFNTGmmfr+FJQ76kflcRCLqXQyDC17fv+0nd/SgRJb5jX9GttlYeYaXBcWlj?=
 =?us-ascii?Q?RbfKyDp0slE2EoCvnM1ZP7o5PyO45I4M3DhcjBXuSe1MtRWSY8OiTFuKCcCw?=
 =?us-ascii?Q?8eoLjbNhurbtHh7pf5iA1xCWdTpKYluzBMwIhSTiljjSe0BG0sZ6KMcEnWgX?=
 =?us-ascii?Q?t74LTRbtXpE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OYIBBipYy/VxmrXXvI1Zal+qOWp7UkzjMDWlT7W6ndtq5Ym3Z/xeG/CzpCb9?=
 =?us-ascii?Q?Ehcozt3aLy4xz5N99BqnCFwTkNVDkcsrlb2P1jcYFEYdhcA42aLzDbi317C+?=
 =?us-ascii?Q?JKYsjQb7uT7+gbAb0x55Cs7ZQCwGuLWqj06RgfMUsqAsQ44FVok7BSgD60Ie?=
 =?us-ascii?Q?mHNA1KA/akZ6Z6VuhOjupi5iaQxisMU3eD0tyPQ/fekLQW/vcnPCUuMg+aFH?=
 =?us-ascii?Q?HIfxK4XdKapwLFVoch1C/DWsCQbX+dF311JAdqkbiNj/ASr37c/mM2065h2D?=
 =?us-ascii?Q?pKDP+HSA2cpx7bEC1cenqyxi1Ef48dI1YfGuQy6+vUUuZyQdFbc3T9cPqHde?=
 =?us-ascii?Q?Qbg6EGxVckAVPHg/aqtAi1gHO+/nmtEUB7ivpxDLQTAzTzRegsG0UdZElM5U?=
 =?us-ascii?Q?GOtmfePzkzdB+uN+9+OT44VlSoiwqLjREprVRDF6HURZvvgFwIN83sc0Fw+q?=
 =?us-ascii?Q?agsutNd3cSGTuqe46Gv3SxzlqqmTG6BtNqICmHGBTqTSVzEViwoRBHiX65fK?=
 =?us-ascii?Q?vs0idKcuOnsyHUxDrnUMa9tvWgirb2C5nkyLf51j6qm4qfL32QSw2WpaX8Vy?=
 =?us-ascii?Q?ETq6fcweRlRXP12XhlcktWo7MjPqvDxLACh9OqYAbXNwT0OBYvHehdd302Rc?=
 =?us-ascii?Q?RtXH7LbfnoOycXHF3FKBxRNIy2iGXwWZsYuRCKjUB68NFDuoguzhYvRtnAWT?=
 =?us-ascii?Q?O8V9flyfivG2RbUM61lV0pm4UI4k6zp++5NPrJ7FbWNx4cAQjBx2V/gaPiSp?=
 =?us-ascii?Q?fDpnzxHT9tFY+xtg1vObuq56SJmWLqM3sTVsdAwYWmWmSaW4r5aw2B2v+eVD?=
 =?us-ascii?Q?awzb75VYNmhbQsFfAAvdY/6sYzw3meOOrqFxu7u3Rk6Okf9j5xElxGHKnBEF?=
 =?us-ascii?Q?hO+37MPAiB9JUs7ZGGqGaZz+tBYFbZbJuwYbQ1s2QeNNMZ9so/0TNgZ69xmO?=
 =?us-ascii?Q?zGGdHrlWO6oFnfWztRSPqvFY43tYjmeCnkbium9BRC91QNr7smkKspQ8lCO5?=
 =?us-ascii?Q?ZpjJMBMOhCyEi2aJYVTArlj2SQCfBfHzgfLJkFYpGCNVZqcjjba7As/YZgU1?=
 =?us-ascii?Q?ZZvfYk4qiWFvUNRaYy1WMvhgfyRPRcSNrMHjOw4JI3rQjm1JYkgNXUGZBsTk?=
 =?us-ascii?Q?MFOhXFFVMzY+6xubWWgofxtd/iIf5oV9d2JQm8Hg5uXEAZtDTYvpeiWg9BwS?=
 =?us-ascii?Q?KsckcLauaRef/CD0S3bQtDB6mbPbfCRSDEnnlHplEVgPywayk33IQ+LO4VC7?=
 =?us-ascii?Q?S1QJHM44dPPMc8noviibFHg5JKkAhOgx0bhwjn9KsEYcWfyMpVxorlSaRINd?=
 =?us-ascii?Q?jb9gwNhQy9MfPiy28Cl1TpHaZf+R0OWVKRj2anwx6kEe/W5plyCegVc+qUse?=
 =?us-ascii?Q?USejnEN1yY8JfQSZy2HMbWpfGGyJIdP8mte+1jnS1HkB6tPi8sTsicggpc7L?=
 =?us-ascii?Q?HAEUejzG0VY2Ejr9YgHTHJ3ib28KwP2ehw2w+UQc323Mf3O9OYua89BkTYuv?=
 =?us-ascii?Q?bLvsiY3vUu4EpKVxCIwjeBKjFOOx5uQp9eiprGnAvNDcmjQr/sz8jZ6XULML?=
 =?us-ascii?Q?XGgRW5HyfbmJILIeXqE7j9uy1mQ6rvGoWDM2+N+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6318ad-3c6b-4ee2-a42f-08ddfa78582c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:08:14.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsoCmmyZJHr2A1/vHDlijoBk7JVdgpzF9rNEm1RZW7YJ04XKhtw8IR22pgYxoi2HtCgtfrAp6CCT/TveUjV2PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129

On Sun, Sep 21, 2025 at 03:32:44PM -1000, Tejun Heo wrote:
> ops.exit() may be called even if the loading failed before ops.init()
> finishes successfully. This is because ops.exit() allows rich exit info
> communication. Add SCX_EFLAG_INITIALIZED flag to scx_exit_info.flags to
> indicate whether ops.init() finished successfully.
> 
> This enables BPF schedulers to distinguish between exit scenarios and
> handle cleanup appropriately based on initialization state.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

This can be useful, we could update UEI_REPORT() to show the flag, but we
can also do it later in a separate patch.

Acked-by: Andrea Righi <arighi@nvidia.com>

> ---
>  kernel/sched/ext.c          |  1 +
>  kernel/sched/ext_internal.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5801ac676d59..d131e98156ac 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4554,6 +4554,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  			scx_error(sch, "ops.init() failed (%d)", ret);
>  			goto err_disable;
>  		}
> +		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
>  	}
>  
>  	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 1a80d01b1f0c..b3617abed510 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -62,6 +62,16 @@ enum scx_exit_code {
>  	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
>  };
>  
> +enum scx_exit_flags {
> +	/*
> +	 * ops.exit() may be called even if the loading failed before ops.init()
> +	 * finishes successfully. This is because ops.exit() allows rich exit
> +	 * info communication. The following flag indicates whether ops.init()
> +	 * finished successfully.
> +	 */
> +	SCX_EFLAG_INITIALIZED,
> +};
> +
>  /*
>   * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
>   * being disabled.
> @@ -73,6 +83,9 @@ struct scx_exit_info {
>  	/* exit code if gracefully exiting */
>  	s64			exit_code;
>  
> +	/* %SCX_EFLAG_* */
> +	u64			flags;
> +
>  	/* textual representation of the above */
>  	const char		*reason;
>  
> -- 
> 2.51.0
> 

Thanks,
-Andrea
