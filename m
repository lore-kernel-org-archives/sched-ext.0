Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAF2F83DE
	for <sched-ext@lists.linux.dev>; Thu, 18 Sep 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187791; cv=fail; b=URsXoDRvuy4QX7FqKW9xj2wuUePBq14rUB5uUvG7rJEBRDWoSxFjyXCs7igFg43w9DijSA5n5pJujLtS7+oP2gsOoNo3uLplTN+P+Uj72a0QOFW2kUagsHl+k66PsP70CkWqRHspeWL1whNJZJ/Z9cbOtAqJJ6ujb28O8j/dNC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187791; c=relaxed/simple;
	bh=hdY0Y3YuhQZ+IodwhMd3/D0UBa7loCO5DFH1qCwpZpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aAiCmikFGFRHaTxfvY2fdMnT1LlQd2Iv9onAEt2Y9mLM6XbAo42cqV+sjwcYEeYjfsXJn0ixfMNAsECE2ENOSOtU1G4DvBeLTOWc2x0XqkWsAz8ytAk8JftgrFeqXjJdOz+5VR9qnrN/88HAiMuVRTgEOtMp3vy35orhL1Em9ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZHj6ygH; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZHj6ygH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr+jdDVdJ1XYzvViL8dHZAXxXVIwYq0UPAgJhPStPnFDcYhQdOeMOstdzVOFMpzyfOJW8q8etU+dWJPbusV17ayCNjuDNCB2djLypunymYDMU94eCkDyHamIi8Tv4yVNUsEFO23acE3Rp81AOBin+7ZW2w7GY+MPnTcqbP7WTozyGVIZy4qLJK5YiYifEsWfK9V5zVgiMMaJ+MvbYqHR7UURuLpse82kd2vuYk8gqJe+ycDJRL3PxQ2REwLbR1sk6nInBrLxZuabU8wPxHFbllS0o+WxedHBjjlC5dw6qAkH79zn4Z4r+f2+GkWsaIuhWMvR5Q2Qq8os2T+qQoPrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir6QbxmCZGxBV2zGI49XQvhhujvEu6wFJco6R3ljHvY=;
 b=pN0X0mP+CR6F2PZ3tV6oY+8XAZ3leDVJRK0FsbobGPtX9xlhVU5IH0sc3saBRjZ3JQkPsF+S6gf4iT6OaMyA/q1YhOUc3IpN7RRXfX0O+PoIWl+t+/i4WWquaTkCLk6fnba8cA+jv6mNl0ujo6edjAahLLLNCvakMGIVy7Tgh9prvX9KPHyX5zuKBjhQpqe6zwA5SYEBnIX2OFrGuzaGDC0/Ho5etH5GvxsOJfD8wjWp8PPj/hZK1cjIV98Gzk4L79xdaU9/wDtsPCOVCp5hG4owdDAHj7yPhnQtLRqwUxdwvroXCGmNKjeMZ/mJkmVQ9b9RQK6RHHpXVtBPzhn8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir6QbxmCZGxBV2zGI49XQvhhujvEu6wFJco6R3ljHvY=;
 b=RZHj6ygHQ7y8FT2DhbQlHup3NZtgKqOTQg+DVJDKiCaVuYzCeb2je3nVxoqbmUn25bw59ZhCjr049V+X3u6D88CVRr+E2z5o6innIt6V8popWjxYZktpFdn6P7eVqNUT3u2oA48WGhKcvB0REoXCD4VFY4CWYMqs0L8wTpBq6Y3QRt+JYV07hqPS/yfHNP0I4hathwuQYRD6EiYY3pvl914froUSOyGbjYasMb04PRQeNAzCzJSoDB3rQP+Yggs/NA1Agu7mg/S5KuCFJkR3A71MJz8GFqaci/ik+2fFv2i8uy0mkYbplmOj3P4cFA0tTqzn5vjiK/mk4aBIqAuQuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 09:29:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:29:42 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18] sched_ext: Add migration-disabled counter to error state dump
Date: Thu, 18 Sep 2025 11:29:28 +0200
Message-ID: <20250918092928.402242-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0183.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c847b2c-4c5a-49c2-a6d2-08ddf695e5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3se9VIY9A/rgLYq/dFMjBcf1lPYb1WDmMoi1umuwTPsk/J6O3E6b38uf6JHs?=
 =?us-ascii?Q?lzpoY3KEVjkq0M8cgw5Kywb+o7Qr5X8Wk1vG4rMi3/Gc4t38LB8souW0pbJF?=
 =?us-ascii?Q?hZu5UiVcxsSd96VQpEgxHX0hTLRUDRZM5hdszXjwSN05ZzMyDHapl+13vglP?=
 =?us-ascii?Q?Rbx3owpl8ukBIZ6Wym8hqGpDzALTAy9o//HvILsObIrFdn6tB2k4FPSMcSc5?=
 =?us-ascii?Q?hnXAHSmB7AW30TpPDmwjylxA/lcp8PCep4YcDHDQacINSP+fM+KYvsh+UWHO?=
 =?us-ascii?Q?lty4Bn4kErSB42+oqcPT6B9b/2IGGpJqyNbF40VJOcAr6FPblZZiAosOilKR?=
 =?us-ascii?Q?uU16bK05C4iRNO0/YOMPCUpc87Tg3rRCLuPzk8fH1kNiidGOfU/ZKvi936cD?=
 =?us-ascii?Q?CMiJvFv+F6DhIZYJi6Ctqp5aWjsNU91i6lYpG+/XzTuQVi8vSFHnuWQ1ITid?=
 =?us-ascii?Q?afBWypZyo53yWWB0/6nfdFOhUiM2fE/ioztr1pNrlJ+j1J1t1yXj0Y7BOPta?=
 =?us-ascii?Q?vIjuzC0CxgtjzZ0q4p+H6NBS3WygQNjg0DLsNIFOV0SkiRv6EfojtJa3zIt7?=
 =?us-ascii?Q?eZ7UDz3LOUzqQ8H2+M40+/pD6LxpLP9eYiDOjfSVdkIKYAvHyLTPOuGot+gj?=
 =?us-ascii?Q?j7tYc3OQLkJZTcwNEFUdlH0Q7uCEJqphVmvnqYQOiynMEp3ucmaX3zi+gJK1?=
 =?us-ascii?Q?9CsElvPSSU6r3sJW0wavPy3zjrtGVKXloUPeXHSqraCeI/5PNX/vj3uWn8Sc?=
 =?us-ascii?Q?nQJ3pQiFj3XTvIO/mVR2fp3HGQjS1O84iHCrtzaIfMTLTWjkfQcyfCrCzyY5?=
 =?us-ascii?Q?0HsNJ0DJIZdhkMDnX6U3zgzu89aVCD3UvgsQTuJGoigd31X2KV5JW6sAH0/4?=
 =?us-ascii?Q?NfINGVj86MiG+MXS0Ss1PlXKaqQjD3q44T+zqhrAfwWAj+e+E9iEu3WSOory?=
 =?us-ascii?Q?S28K2fJqNUbiVQ+PQBZ0H49T+5kAwyez2cTGsMQ6J3cBhOufela92iYJIpMV?=
 =?us-ascii?Q?xZPv02fBtlqekQDFxDOIGBkAZAtPvB3thl85rQ4NNCM+NH/vw3rAk/nPoDfG?=
 =?us-ascii?Q?DODqUhBDJYg4hJezopDYxQotVehLrGfaQJxySuuWjFmEnzVx0stUg6srS8XB?=
 =?us-ascii?Q?N3zSmVetcX04hPBkPxcY/C+zrbNbIn0ATVUG4tYSziRdbdOC/IycvwTAgUo8?=
 =?us-ascii?Q?6BGccA2+fErpwx28Gw5RmtQYOdIhcKkHShwnupV8PfwvGMe0IzNGvaLK1rcu?=
 =?us-ascii?Q?rQTWNljUpO0O3FkaQDbsWifjMX0cBw74ZqL4w7zKwfJDm9Lo7hk1gFC4xMB8?=
 =?us-ascii?Q?PSmocHhHWuO0RbotC6cXhXoGVb6g5lB+2ONcNA1lwC+dmYTifn9AtnWzh07B?=
 =?us-ascii?Q?C3F2+Rtc0hV6vx/B3HHu7Xo1V0oOAqvPTOosXLyAagFO7Ejpd9dft0qpchtZ?=
 =?us-ascii?Q?ezE/l9P5KTA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5snoZWYWpgWlvH3ZNE1FWVIvbC7942VNMkmw0L4AH61IWL0mQ/+70DauL8V?=
 =?us-ascii?Q?W+sSQppGeAb43UMKhvvSuhR0YJTK+IHoDRPu1RHeqg3v2sDEGse7mxGAsI2i?=
 =?us-ascii?Q?KgvUegD+vinmkg1srmWrNOABtYUNBxPSpHXDc51HX5cjdQW5w0jXP0aihVKV?=
 =?us-ascii?Q?mkDEZfyQv/jJGhWhDiVibBO3b18TJQxmqlUinj+5dw6PdBQxaVjkkUxqVKrB?=
 =?us-ascii?Q?LHnbiwQHmkY4Oakx+MyPv2H3FzCLWejdgKTueeMrYrufDsIbAYnKYL/Gzc8L?=
 =?us-ascii?Q?4HvNMaW3Y+fhbYzfr6vlMWo/G7qJXU7YbXigsD/ub2yk3r8es7lsZb2FUyFM?=
 =?us-ascii?Q?YR5aIISNO9PwDv14WUnXz21FlEnCSBpHu02DsZpxlQYE6tqCYptG48swZV/f?=
 =?us-ascii?Q?QB/aTrOtgIDQC1oOnfyZHsz8gHJqZC9/lx93PDFn5AXo8Nt55PQm6jIPWrCf?=
 =?us-ascii?Q?g98McsTCpZtvWVovZo/I3k0/IdcDcIIIaY6UBpYrBzolacsM7NV1fFQyz1WI?=
 =?us-ascii?Q?UQ+DFdHUDt6twL65k+k9vzeBLlSXhG+TzGWVRDCYFHOAbwjPOZOc0dgjRlxZ?=
 =?us-ascii?Q?z/LjiNC53c2+771BUKyCfzf8CFKXkzZks0lpg3eJDznp6JEwV57KMf9uj38N?=
 =?us-ascii?Q?gSLR17O/O9FzSq1ceIAI0iKNj6DmSusqrECJEQ/Aap/nnkyX3vXk+tQ1KvAR?=
 =?us-ascii?Q?5CfMcYUJFB70YIh/2zli3uahYcG+S9Rn7Idz6djIZKz/KQfXk5QpTi5onvhg?=
 =?us-ascii?Q?hUyfawZ854PjG0jKFKIlH6Ax0FjJ5nAfNtfCrwmcveCBrw7/V/XU8o7bFjHb?=
 =?us-ascii?Q?v+cdjTm9NQO3lcxZ0BDIcPTVQB4t7kNLb0i86rlLgEM5VdjZsMOrT51C1IDn?=
 =?us-ascii?Q?uFCsgFOCkvOhcGndYkhOKUe79K+G2jq/e5z91AcEmIjOsIcSSkiuJ5J/KCl9?=
 =?us-ascii?Q?crD3xDo5oWO8slKWZyLNenFMgvu+5mcFxsDsCFCujCP2XmdLqQ3RUIU1Oci2?=
 =?us-ascii?Q?eKlsxoLsi3Y6B1eK4pW2ILWwWD80ZzxzyiwcjSOx4qF2SeOAHr+435T/1Opx?=
 =?us-ascii?Q?+s4ezEbroll2dD+A3VWkyqghiqJb8mhd2iwOWcEbswnWsNCcFc8Zkl5Blhpe?=
 =?us-ascii?Q?EGGRtSzzwqNBUyp3Kkt+v9Ap8khA5fbUDgtXFmMnTYfK/AqefL+mWVQphkJT?=
 =?us-ascii?Q?ETZ+o02a7CRwGwqwdFpv/ihmjSvJTMmvgMNCfXaZgV53dVvcCVQPkeUlumXk?=
 =?us-ascii?Q?r4cFrXEGNeSPva95sMLzU2NY5BKMzEgbSST62Uz2gj+ILLg4bH39VK4MRQ4l?=
 =?us-ascii?Q?/8tTsRMIJt2iqs+nuX1ggv1m47BEImwTheKHhTPgkWUnvEF1MZhTgcBhwV6H?=
 =?us-ascii?Q?lSG5EJ0p7KP97Ny1xHc6uOXP012QuhlH67DzzCk4V2LuSzXQ2rEhd8i03hIt?=
 =?us-ascii?Q?QmdUXGxnjUklqn3Q4/3wRcWo+G1bOCdij1SW+oah8FySdM8i1JA5+h+j1uSi?=
 =?us-ascii?Q?CCERzpy0JDmdxNHZCrPfqef0A+PKIBmclfFulrRusuBfDDle8a5zkK0SxIty?=
 =?us-ascii?Q?YDL/OACYblwGpXl1y7g/bo2R0TFj2LuElzn9kcP0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c847b2c-4c5a-49c2-a6d2-08ddf695e5e2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:29:42.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXgC/mKUjPpl5mPerdg1auqIGfiHtnltmBImG+XqHhpqA/Q8StGDncg4G4Mgd3b0voLcKOTWgYdQ52QxIH+Hsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6

Include the task's migration-disabled counter when dumping task state
during an error exit.

This can help diagnose cases where tasks can get stuck, because they're
unable to migrate elsewhere.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 477eccf023388..e03bb51364661 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4167,7 +4167,8 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
 	dump_line(s, "      dsq_vtime=%llu slice=%llu weight=%u",
 		  p->scx.dsq_vtime, p->scx.slice, p->scx.weight);
-	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
+	dump_line(s, "      cpus=%*pb migration_disabled=%u", cpumask_pr_args(p->cpus_ptr),
+		  p->migration_disabled);
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
-- 
2.51.0

