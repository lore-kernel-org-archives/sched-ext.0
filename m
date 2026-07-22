Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D730C171
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727515; cv=fail; b=mfEqXoTnKk/cY8GerOoGzkNYj+LflilUeHQacB6TPmmlV+3XUJdrVBbqf9pjx8NgnsJle8KNBLdRcwyU0sKBJ+ERKou/aqrhtf60HIEAdXIwi+MAgeD0dj5jKfZ2PjPZNZOqqLyE9O3jNS+uHb1l9/9xRPugrNZR2+9A0nQxAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727515; c=relaxed/simple;
	bh=2vihxuej93muhWnuU1aLlfi03iB9IYOUgISXYXFqLTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EG8zTV3e+S+n9mAaWkEMVeT1vG5VW+4R5aA5baJOXEPuaf6SQMu3lj5i+S5z2gg/rqQmcy0tDCcGeT6WLbmddkJZ3Zq8zRWWMtpbt5GKjLHGlBMhuT+7Eu0ooNBXm8soss20DmxGzGdGEKMrXu7D+dcAK0oMxqSSOvGV2zRC3qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xakok1IG; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xakok1IG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8eMhuaGDzrefPq+qC+qmQ0EfdZS+RCHAuIHr/dAsUqFaBkLKCUHbeuiXBiEC2E3J+F4nKZPA57/zufFnt0bJ2OMHfV91/9qvXRybQ4kO5Xpir6ibxkmX7vhaHsCl7+ufNqOWGbuLBAbjn9zBfDASnj+dygXgf/FLWmuKKQYDJU5GYlQdQYBEkfRMYTsE7D6BsRE9nihWuH2YUSkd11cPkytfub4PkpdiDAPzQZlRVoH+hFzuIx84c/ajPkvLzmwCdizEs/74bkbgWLiC6TMvE0PqArrfcaRnvKusp9HM6A+2ubIJUg/67AoL3SK19zYcU00IxVdS/VNdFgwZVPslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiNU7or7cKR8bMwoRE9fQ7IQhLeC8WtyjYx6DS0y8ng=;
 b=jEqqUrTqR3WCU4FZEXM9qtFwU9GIYVM4FJL9dEo5N8rC/S5aWZycCXgl7sJb1Q0FvoXcQDOK3MhHw5ZVc1R8FTQZVLTNdLEISFmGY5r+8A210RmUaBJZ+Xpb+/AW51ySLaSYraw8CZIhhPerajBjPFftnBNwpmfe5BKpHY0E50wmL77qylhOnU9n5dVv2HgsgJSh43uVKwxFjn0iTnmrRMJh9V7iH4c6cMLnbuxeVP/nKwRdzCTihf9WaQ213DDLQoZ4b4Jv2NRqDJ4HVSfSx+E6/SqbAKthjAev2uKBwkwTE1J5xhOyloprxPQzidVUVCoWdgeSKnecpazlwAQ16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiNU7or7cKR8bMwoRE9fQ7IQhLeC8WtyjYx6DS0y8ng=;
 b=Xakok1IGX7D2GeEoJlKSHu7DKXkszvcjCgZsQNKcst2MvPTLFZqiQXuBf7vut+iRLubL3CXgql/0t03Nmj5YSHfy50UU5cRt9tAys5I6LZPVSTZO2NZmZwJ0wZ/ySm3qc2nUgtUVL7XssaBNt+EPGBTiq+nq/vjCvJE28tuNsWiZR8ziXj0KWGGO5c9AuPrIvrHMK2M1kH4UZtYFF+r9fs1eAqP/9L48BqcbzHbXeRN1glDk86+SSQO9JhZj0qvE9cs62OQquoki3gZQeIKWx5O6aBH7K76VC3s+iZyFwgw2jHkWMRoYddANjWql3qVD0zGVeiCxcXTU9b1oM1oYLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:38:30 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 13:38:29 +0000
Date: Wed, 22 Jul 2026 15:38:19 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cui Jian <cjian720@163.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix stale errno in scx_sub_enable_workfn()
Message-ID: <amDHy8Dw8c3B1ywg@gpd4>
References: <al-tQH99wT1RBfnd@gpd4>
 <20260722100352.36627-1-cjian720@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722100352.36627-1-cjian720@163.com>
X-ClientProxiedBy: ZR2P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::7) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: ac455e43-5b47-4d06-8adf-08dee7f683ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cbMmhd5KHka0+4O6Moo8CtIiHyhGlqI3TWFWYUBOxtQdhICBMEMkkgEc0ANr4hmRw5czRLK/zMIX3W2dbu9JENfrJFqgiP8k5IZSDhIQFrAYOts+4eHO4/YkcATVTixlOSIxkXB8ONyKNdnigCbIel1CzRSg9i0fnJPb2a9PjWYksh4nAg8/1DiPzFLBOb/qtth/abjyByEFQXREjg8NHuAlHcONERWoLMqTDGRvIEZvV//0RcrndC6zfIyVZMihl8HlnMmJPhv289U++mUcPtsacJYDl2mkxl7G25TM53Byy7nm/kB/OdpJrDYXJw0RDyFDfIrbMDtO4XaEnuwQngojbYizo+52ZOzNgeRar42IdV+IzTC+PNLUW5t74Vwiqd4fj8sEo6Nz1emoN4h/eI6TUGbj95keJ7FTmJUrTkfgH2fWEI+FQ/4EqNM6QXtgf+SBlfZr7ZF6RWbcZZPNtjIrZ9A3qZMhrCU9JPZc6Y6PXwL4ZkZI5r5xoni6V4FN/Qii4lV38eOGB4fbwKC4bBz6eLFx6UREL83dvy1eFWVwfFD0S2tAJ/irDViCowjNZrL8xA84LeknM5TjtOjSLDec+C9Kb3fU/XST3eqE9eN5RPqm6rlMnaTz3/TOR7kmoOD9WYU1bOsrl6O9qrJjAzhABAS9qLFMIH8j11Qhhx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOkvOVbPySFJFqt8zeDJtRUxTzIfI4nbtNdDxqvu4chEghQHdjhffmVyaHtZ?=
 =?us-ascii?Q?xpL9sbNccF0vArDzTwW/vmv6IttoyGPWizSe+/wAFTCbmYhEgYo1796OmXXM?=
 =?us-ascii?Q?DW9HC8aFKoJmtVAoZGrlW/nBAbjDXqfAd5LXqWe0FjKIEWAdVN9+ZotaOEZd?=
 =?us-ascii?Q?xlFaYdz9OiBriaLhL2dWEDcyUXDSYUyKFLZ6Qgrn4aK6rPjhXbGragaZptNW?=
 =?us-ascii?Q?JJK1tjzoTLmKM9iUtouBIrdj80RxUVkclJUFmUwB7253lV2+iuLvicKqiWnk?=
 =?us-ascii?Q?cY/lQYfQ5g7Ga5Qcls6s0wcZyZPzjRva0wKIDCC6z85H68dhrOlqXv/4CqeD?=
 =?us-ascii?Q?pyzxJRPMrO4NvIvQUGFzqJ06aUybQQD+8N+cRemV16wklZUC2aRTbWhLKjW+?=
 =?us-ascii?Q?a02npzdqBStb0RxsIy9wXzKDFbLF8EAW1ksGFEh4h3EsNajN0HCfQ0q68OxB?=
 =?us-ascii?Q?1yQ9RNGk6yKpET2/DLYYy6O228PQi+nG4sDXN5tBkC/27c5Cb6EgqbVXC67O?=
 =?us-ascii?Q?tfsBYfmDlRC3u3QlD+Cmga84KMUXAI9tQDvtip0YszTDAKS1kydmdWCSnXJT?=
 =?us-ascii?Q?4H5H54tbKXBhaBUhAypZu2ZZdOGe5GWJYki2ADnaBufLfkISqnIECGtex4FR?=
 =?us-ascii?Q?G1K3hcarqZIVrqMxcQ1ObAVT4jc6DRmqTeewOFpa74O1zrQ0axV7JodW7E/b?=
 =?us-ascii?Q?oykyGzWMzgqPbXfUj+IlYgs6NZsoPKH/ZbKZRLU5i+7JVzOh8H4c9RMAeoef?=
 =?us-ascii?Q?9ufkguk0GWJ0CrN+GOtubTQWzDweE8554bziWQb8naRs4k57p/ghoabOqvRC?=
 =?us-ascii?Q?luPzDrUeNWDzh/RkjFuyXTGwlCwcDdXy/HOLS+5Vs9FR4gQEjdTdKhdByzp2?=
 =?us-ascii?Q?BMav7mL+zWSaZgKUZtHvs5ds615Qy9vtfHGOH+FlTbxWIDdtPtkAiOOWMxOX?=
 =?us-ascii?Q?NFn8bXNhVq+X1F/mJmgh3XMqFinjlIbIGzokQryxvG1265Vqzrlr/4+GO1Hb?=
 =?us-ascii?Q?f3xwXrWBzsZU130izQSFOyDwj5jipqsPtykKcxzMVaVPw2rd9OVFv6WxrPsS?=
 =?us-ascii?Q?G/UW/mPpgffNCX1McIvlZzk4L6Bb1fAuhYAMVGX7VnkGT1YQc7DQs//5OosY?=
 =?us-ascii?Q?TWD0HA1vFKjLInzx42/UGSjDgxjz6thxwfS9Zz4D+llxMnM/q3xkxsdIdPaF?=
 =?us-ascii?Q?44053gOVec5MeMQRKX/0TER+qJ/YQq4j1BCcohsUWsE1OwGJsd2NQRtk0ZFo?=
 =?us-ascii?Q?7jtIdX2Aig4soNdT5C+w40j1dHkt0k0t6oqHKz/b8l4l9BblXqrHEXHCsNrn?=
 =?us-ascii?Q?IqeinrGis2/62pbWrXVGDYlmMzpO4E4ryZwmbmEPcSnQjepKn3oiT5ctCMsK?=
 =?us-ascii?Q?GQsyTMnWAWO0E75Tgnsd/sR0mqqe8hq71WML+y2Qv/DSaSFhnBIgyoR5Wcsm?=
 =?us-ascii?Q?qJhZO7z+Pj6jfHbYcCWJNfiXv6vvud/0TdLbAq1tn9IrPOihQWy07Uvq4qwf?=
 =?us-ascii?Q?Z/SYsJH1wDRLgEFOdV6/OE2F9AfxV5yKEg2CPhOPB9IuUroeHo3TantJL+9Y?=
 =?us-ascii?Q?Hw0+h5MDhIYb3nNJnTCcm/tY5cpsbVM0tzR7NVuaeV8wADIxqX4OVl0Xwwpk?=
 =?us-ascii?Q?+B76Z+uIF49ah+yqZAZAYpqyUwe9cPJv8N3ioCPnjg0Bb2ARvhgvQFt6VcgF?=
 =?us-ascii?Q?lFgl2jz2ygCfnEOkFQhCb7eNJ/X0r+++tvu0YG0AZtCGR0brGW2Dooi9rnn6?=
 =?us-ascii?Q?7tLsU5vG2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac455e43-5b47-4d06-8adf-08dee7f683ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:38:29.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT8bsThwdsvABJ+f/7YqRziBwPKBHsFbxI1ncU6dehZqb4mR/NTo48JFH0az8YVTcg610tF577rlSAezYcg0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

Hi Cui,

On Wed, Jul 22, 2026 at 06:03:52PM +0800, Cui Jian wrote:
> The nesting depth check and the cgroup online check in
> scx_sub_enable_workfn() reach err_disable without setting ret, so
> the fallback error added by commit db4e9defd2e8 ("sched_ext: Record
> an error on errno-only sub-enable failure") reports
> "scx_sub_enable() failed (0)".
> 
> This is currently harmless because both paths record their own
> scx_error() first and the first error wins, but it leaves the
> fallback broken for these paths. Set -EINVAL and -ENODEV there
> so the fallback always reports a real errno.
> 
> v2: The validate_ops() path from v1 is already fixed in for-7.3
>     (sub.c already has ret = scx_validate_ops()), so only the two
>     remaining paths are addressed.
> 
> Signed-off-by: Cui Jian <cjian720@163.com>

Looks good to me now.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/sub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index d7842a609d96..6da6c91e4287 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1331,6 +1331,7 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	if (sch->level >= SCX_SUB_MAX_DEPTH) {
>  		scx_error(sch, "max nesting depth %d violated",
>  			  SCX_SUB_MAX_DEPTH);
> +		ret = -EINVAL;
>  		goto err_disable;
>  	}
>  
> @@ -1378,6 +1379,7 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  	set_cgroup_sched(sch_cgroup(sch), sch);
>  	if (!(cgrp->self.flags & CSS_ONLINE)) {
>  		scx_error(sch, "cgroup is not online");
> +		ret = -ENODEV;
>  		goto err_unlock_and_disable;
>  	}
>  
> -- 
> 2.34.1
> 
