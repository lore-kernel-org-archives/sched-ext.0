Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DFB35F182
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930643; cv=fail; b=fyTVsc/KyPkMw6jQzn9lVz5s8xTthjC9j/Pbq2MhDngA73NQWKcKDel4Bx2/V4NmRyk04M3v9xlBeBLCa0/fV5IOk0vA7k6aGeOVG80RntJK53ayquo+82Hl0p12QGfdNPU3qaZK8sR+ksqru1lMXG6SVuFIVqMOOd29ZQ32z2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930643; c=relaxed/simple;
	bh=hGQtMTdSQrGRvO4dnhozGLc1vLR+CY+HatgFgp35xZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7/SD0Tgcu1hvAxWUo0TILXp52lb2XN/qGCcOPQwJjDdvIcrAhYfjD/hTX5SL81Nxe6bH0pAeLzArExmDK49kAsDy74AQxf1tdy+/kJ26vh5BSFIFwLY8WGesrsi2LfTFWT5HE2fE7uuypeTPARdhJgwT6BQQ+UBSGrslZcP0Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKdDuvmy; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKdDuvmy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBOC3qvFxkUsayzzIDwWs23RhLysLKS97ypbvCQhEkuL5wJ2SdwylkFZta39d5oYM39nl/8griJks04yqCrQyaAznx/pMFtJ+paLnaT3LEADHZMJgYbW0UCkWrkl/wCSDV6GgCAp2DYGDF9ZzGy7Ly4LIbi+B0bX3T2xuwJ1Baf4xRB7/ETJqBOweK57y6WSka5NKSfhNbA4MCCmXCvJRG38TD/qovKAX9OeBR/qtYyaGlKOYwXPjYzkUGFLlZh/tEkJDUGwH/NgjQio2fTa22gY5htFc0UNSHnAttbbfsOIkpg+en6y25cmhONgyGNIUn1wfCKBEH/AJfNdGYuHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhH1LesMufcsRlW/K9JvQCE7vGrYn4ONzVtPwGauXGA=;
 b=X4yR7XHpyC0dHDdHzh2+AWL4DJ+JK4IC9c06yNiEhhJnGTFwA9y6SEZp3P8ueWvEoJptjnMIVHezZSmVV93lhEcwIDlneIuJzQCGLUB3VkvrX/d6wUOrZf6R1YQkF1wleQRdHYGizsjyVKFWkW/Fv3r8S2KIZddcr+6vg8NqXBAyIxOU5TcjAvn+m/YvhUTnBe9Lx28634fAAP8Q++WqJDOaFnjr2qjBJ71s0k4+fgTi/T8EcFP15C3Ti5+kz4dbmTkAqd9QZwa+AblLNUZsUyZ72kqD59A0ifjbnsbY9F+WRS0fr5bW9dAJLx9jiLtUgtRMnzSFeCNxM9M96RYIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhH1LesMufcsRlW/K9JvQCE7vGrYn4ONzVtPwGauXGA=;
 b=HKdDuvmyaqAd51+vjVPOOBbSWwc7jYasq/5NovrFHua9zSE1VU12UXGlqI67a7qPeTWWkchAnDm8tHCTVnJPDR79SpxXcwgsP3lwnuu2gT+Dc5vkUSFUcdGNsSyAS3T2h51kyIS7dIKT+rHE9zwuXgduCGEV2B/rsK/SRgWIADRa5n9Aiv0bmRlHhbH56tvt/Upzu18vBq4EavPlN23oC6WWqY8XSpwsVoWvHYKLQZukis0ExwYnfVMA+VgKVXQI4pgO+jpDRRckQhlbCP29s0MDJ7JAF/CBTlYmbyXi6jJ9AaRC3E2Mjf6Tm12hS/0er5z+Ghr6Vjv0O9DPKa+H/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 21:37:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 21:37:16 +0000
Date: Mon, 4 May 2026 23:37:07 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kernel test robot <lkp@intel.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Add __printf format
 attributes to scx_vexit() and bstr formatters
Message-ID: <afkRgyCoZKJO1DQo@gpd4>
References: <d49b20910d6d09389af138f45acbfaf0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49b20910d6d09389af138f45acbfaf0@kernel.org>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b03e18e-d04d-4ff1-6ee2-08deaa254fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MGGBpSFIRDXj9kjBBmjYsB1eqhNyq9VgFkDLmh4MvDXaX+W4+XSJOZV+O2aBfldhySo/WhZHDRAQu1gXTN45NripwwS9iGg0veeK5jU7L3JoYYoEbyZkDHeVhX9SZnN7QVJE98AfHXgoFVthO6+zs4mG0uwPIVyE8kx3UbnNy6gLw3SGR+9f+I6iDQOtd9fnQNCVEt+PaKCSy8GSCOWDlCUkM4v9wWYPrGqOwl4TfEI07f/kbzcOGBAqh42bjMgpjOFLIS/TlWwjn7zYYP/GTMhfU/kcc3DCwKwcje5l50FT6NkgUFeID8E1AMvZoMIWCceOCNvMa4uWjUIuC9CaBtuTf7eMVTolktlaaQrkGKvxWIgyqJ2WoZS8AzvXQS/oxxUr3GffcaCBwG+wN3Hs2MveenjvV3eNZPPwAx8LJZUCDYnbqsyw2Rj9Vn2fxLFNGsh4Y49DneJlroyhkqxuim9snoa2p9xRgaykQKdz7tWf3vfQmvXtvXS7J/qY5HJLDJy3bekYiigSx47FkxPlj53cnCOtCUvG+9rc8BoR/2B9xZHZ+F+RcfXy1ihqQ1ugGmu3KMYG/ftA9M+mN1YHVkKYJS9rACTkW8EFpbEq7aFwfVtwiF+M/MEmYtXdBhhoRLDCh3/Ggl0d8jSmPIR388Pgf3p3rTrdaeK7weThe6YbdIr4e1RrB/+Xdzhc5cALlT6g3FXOGYm0YqEETsc4sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GWFsIzR47cmRST9br/xkQdnCJhqFGoDec8SJ2Afln3O6RnEoH5QA9DlVfAQ5?=
 =?us-ascii?Q?ZMV45ihc+nINFo2Jnw+NG+2NEkE/H4uxJpTEY30WOPam0088Kk2rzHUQAXcs?=
 =?us-ascii?Q?MKJOOQXHCaqgR7f02jU/W89tmGO+J7qubk9PvAX6L5+jGfulQ4fs+CshN4a1?=
 =?us-ascii?Q?eq5gZ4cc47bevpM6+V0TAgOBpJSO9NjRjErfGOHWMZjUtCpmRBWB2ynDu4jY?=
 =?us-ascii?Q?0A370NspY6RvaxgW8+BnYwpRZOjz63f3kNNUYOYB/9HMBNMXZwzh+JcQ+3kA?=
 =?us-ascii?Q?jF2NUQ1etV3PQ6mpDOxLu8vq8GO8GWsq48i3wes9W1AqOrxvp6LlSP/1RWic?=
 =?us-ascii?Q?2Rjf/6WAlSoskXJOPrswUdWBtOs7f46dfg5f9Ue/LB6owS+6XTXWi0pQ2yF1?=
 =?us-ascii?Q?A2TXNMESTemjQGRge9YhJVpH1AmAwViXS9Ns1EuGEK8/CDsyYmJozOyAa6bO?=
 =?us-ascii?Q?6hyleu6qy+ZvtdQTCq9J3mpwQUqTe7y7KBDjSkEv3T3vFQcKpjc55brs/J1A?=
 =?us-ascii?Q?KqZVBeZyePcwUdYhtYKHUx9e8/phioEoWXyb0QUCqcz0edowbdzRbiP76/Mv?=
 =?us-ascii?Q?/lm6edeWUSxRbl67dGvIK3tLurvr8iZxxZYiCzIdGShzXkISnzIuCu9ZAU41?=
 =?us-ascii?Q?WWb8eI7V/3KHd7STwlsSDzyWrHntqMbdhugsjoB011k8Ox6kexlsq55nBzgS?=
 =?us-ascii?Q?lev1/fEf5HdhfsNE3lK5kofmflBCkO5RXbpX07p3WGZcVwgZqSYl3XAL0sCP?=
 =?us-ascii?Q?SD7+d+LmOJwljIDsiSAHMw4iVqB9j+0VtHqdU8qN0/7L9hroPOGX76rSLLCL?=
 =?us-ascii?Q?8iL1vZUoA09bkFDAJshf2JSj5zd5rE2sRWxvdrC4Tu0FlZFrXYFLSOlXRS+W?=
 =?us-ascii?Q?qxKSYiiHsd/4W+r82YhCOnhNmT37Qn90RHWQspy+xt4A1SaDYg1hFK0SNzW8?=
 =?us-ascii?Q?Gtfy4CE3HT4H789DDrgeR6yNtNURlDNKFwKbxUN9qGgOVOLs7K+MXmXpim6w?=
 =?us-ascii?Q?p/avOOFFUuSVUryPpjb9LKBPRzWdgy9TnQ7Uxn7fgjyiZMyJL3O06UfMjEUi?=
 =?us-ascii?Q?18ab+L6o11Z0jtlsiChw40jpR8se29v3p5AzjIFlK11xi8HggqJlL8u+oZ0w?=
 =?us-ascii?Q?xSY2uUoskwOilYhWYRfOzrcYeaPvZdga9nB1Fr398XQFFNXr9m2Mc5xlGODg?=
 =?us-ascii?Q?tDQvYulCVEh1R6bJMqWNRxBN+B53l9CZyb93sUOH7sbw1xpp/5xAqb+4RXXP?=
 =?us-ascii?Q?UGM9rQog0Sj8o+8TxIbVd0LeLxotpGbDpE2CMq4cJuXPrUCnKblbEtX2d0Bs?=
 =?us-ascii?Q?crsXScOheJGhNxNV9j170qZTW0XOW/FHaBgH4LXWALTVepjamBlc5zryCzf7?=
 =?us-ascii?Q?amJ1qDB1fPvG4ngWmPtUits0djiRexQBqBl5xRCBWOsadhnUWe+yocj81Qtt?=
 =?us-ascii?Q?3JbzgQHdarTjXycAE7rKZFyC2HN1MRTL28Ps264p23+G6PZGDd7M0ZxYZshj?=
 =?us-ascii?Q?r0oykqsCtKuR+dkb4dV+wRGlZVXSS/rmlHNZntDtkWGpJFfH1hwP3KbUPWQ7?=
 =?us-ascii?Q?5b3FMFt4B9gr3OxyfO0qkKCKf8vk41UsE2TicaH1EEq2Bi/73kg9Nln8Y6Ao?=
 =?us-ascii?Q?DB2jR2oH4hld7IN5YqnPyanDiXFNB297bgQ4aU2sKKwzyZKzYz+UBZ8MmMJE?=
 =?us-ascii?Q?oL7CzzFZvCddkz4Qb/D3HYwZenR9hhzejz95hVayXsg7wLua+ir82i6Yf2o6?=
 =?us-ascii?Q?aS5fKGhXFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b03e18e-d04d-4ff1-6ee2-08deaa254fa1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 21:37:16.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJSa/go5uko+f3SzYqRwHosQSOX2jo3vJJ69OwNBKrrt/TcLDefj0TI5fYhcLW99kGJBSK/QvoUjQ0ydgITW1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

Hi Tejun,

On Mon, May 04, 2026 at 11:20:52AM -1000, Tejun Heo wrote:
> scx_vexit() forwards (fmt, args) to vscnprintf(); bstr_format() and
> __bstr_format() forward fmt to bstr_printf(); the BPF kfunc wrappers
> scx_bpf_exit_bstr(), scx_bpf_error_bstr() and scx_bpf_dump_bstr() in
> turn forward fmt to those formatters. None of them have __printf(),
> so clang -Wmissing-format-attribute fires on the forwarded calls and
> C-side callers don't get format-string checking.
> 
> Annotate the six functions with __printf(N, 0) matching the fmt
> parameter position in each.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202605041112.Y6OG7v9r-lkp@intel.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>

Ah, thanks for fixing this, looks good!

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
>  kernel/sched/ext.c          | 5 +++++
>  kernel/sched/ext_internal.h | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 966a846c213c..7ac7d10a41be 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9338,6 +9338,7 @@ __bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
> 
>  __bpf_kfunc_end_defs();
> 
> +__printf(5, 0)
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
>  			 size_t line_size, char *fmt, unsigned long long *data,
>  			 u32 data__sz)
> @@ -9375,6 +9376,7 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
>  	return ret;
>  }
> 
> +__printf(3, 0)
>  static s32 bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
>  		       char *fmt, unsigned long long *data, u32 data__sz)
>  {
> @@ -9395,6 +9397,7 @@ __bpf_kfunc_start_defs();
>   * Indicate that the BPF scheduler wants to exit gracefully, and initiate ops
>   * disabling.
>   */
> +__printf(2, 0)
>  __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
>  				   unsigned long long *data, u32 data__sz,
>  				   const struct bpf_prog_aux *aux)
> @@ -9420,6 +9423,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
>   * Indicate that the BPF scheduler encountered a fatal error and initiate ops
>   * disabling.
>   */
> +__printf(1, 0)
>  __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
>  				    u32 data__sz, const struct bpf_prog_aux *aux)
>  {
> @@ -9447,6 +9451,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
>   * The extra dump may be multiple lines. A single line may be split over
>   * multiple calls. The last line is automatically terminated.
>   */
> +__printf(1, 0)
>  __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
>  				   u32 data__sz, const struct bpf_prog_aux *aux)
>  {
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b4f5dd28855e..0ed79bd891c7 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1477,8 +1477,9 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
> 
>  bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
> 
> -bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind, s64 exit_code,
> -	       s32 exit_cpu, const char *fmt, va_list args);
> +__printf(5, 0) bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> +			      s64 exit_code, s32 exit_cpu, const char *fmt,
> +			      va_list args);
>  __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
>  			       s64 exit_code, s32 exit_cpu, const char *fmt, ...);
> 
> --
> 2.47.0
