Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F8309F15
	for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387810; cv=fail; b=uURQVCTRtpHHRhLVZFnsZQjsfqjbwQXmwIluk1FoqtDggK2VSuMhiR7oWegbu00B6TgopYc5Yl6o2T7Wn6Iyer+7RE2FDhA20NUENmdclssQkeYFMEranVGK3Swhh0uAe9Ua41xVZ0grwX7Nd/iIu15UDskHCWGIHDH8B949Sws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387810; c=relaxed/simple;
	bh=Qxzt7j72iV3X/Sru2P/X8DKQTRdODVtKjugdouXdSMY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UHpfbRu8FPL3SdWijSryhwx3vJlXT2/sbf2oTiz3cAvzH46wxKsM4cRqwsirYBVoqQmgKVJfvNPfBcofJPzOVRS3qipW3nsIXjpiyRX0RixtcuJWqxPEyYpW/7Snwr2Zm4Pwarbiw8eGDZQcvpzd0vKVoS+zjnds78UMyiF/dLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jChrGbPp; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jChrGbPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrEAoTM96QPbGG16/yXypjgaK0KYxswwzvHN1etlvSNiUDPIvMHbMlMxdI6otRiqqvl/S04GRXOU7Nm+AuOOj79peocjh4C7AH4AEFs2sF5ERZypcy3ByLIs+OINkJucgeKZPqW9L2wXQM0IEdBfDPl91xC/OFbxsBIZ/Pbw6kzuxBjGRafERxLzXEUvEivYgOdJGj/8tX1oil2mhy6p2JO0zmaynkh3LMHLmtP8qTVNDnEJytISYAIdje/Xnq0vAAXfVrh+vVYXzSVn6PPCFLC0A86dFw1k/QOW/0dpmPaTjDGvFz3n4Q6OqutOZnppijL0iZW6foAOsz2H6ZZ3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCfKqtAyH7WiEJRBnKwFl0rZCOzH64oaEcl8sNOwwWI=;
 b=ssrtxNK+C0LPrhf3GEH+JmKwnJhXw40HtN30rzHD4hH1HKl9WGFeFG4dPkzo7fFUxlb0TmGYX2VHvlCL1/f09zALKm80zBhwJjOLZtoE7XdxU74xfxBn6krxFkMVz34lYkXPcS4wfB1q8J40oLfekZLWXxfgkqI+UpVefpuGE7oLEm2aUaNIKYAhVDb8F+9Dv0k6a4JQB4DqxZzAaI9oLN+PnZYsx4Jh0W2Lj5ojz2fQHw0/UwVHYnvk9Z6KPCMjuyp11P0jFCT5aCpyE98WCBrxjeUy4GSN6jcbBx2rmBtWHGo1RPAHNPrcZj0u5zAZYaTGG7N+EDJM310j5jKOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCfKqtAyH7WiEJRBnKwFl0rZCOzH64oaEcl8sNOwwWI=;
 b=jChrGbPpWURW/7UCnuoOm5XvccWe4fGuLWbWZWFZvOthNG8Th7obYWS6eLXH1eOQnncEqVkU07P/pili6hb3r8f3jG0/7DaRL19Hi8vBkWq+6WEjxZvWs7aEpFGxgTyXc/3rrp66TV50GV5XhTNfPPEOgXIe3+upTTGP2qFWcxU0G5gVLNyonh+mMLeShO3VjDB5aK77/5X1N0/aJEhaOWhDal4DQbR3G4mXyPbMZ+DyJhol5nv0wNpj0vg1J3Mc7NGV31PV156jUy6RAQxFjaJvX5vejsU0mt4wbSFQQSfjKQopCxjOBCB/P6KAaGD4cEl/0hm1YLyTzR/90AfrVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 20:36:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 20:36:42 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Phil Auld <pauld@redhat.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.18-fixes] sched_ext: Fix scx_kick_pseqs corruption on concurrent scheduler loads
Date: Mon, 13 Oct 2025 22:36:34 +0200
Message-ID: <20251013203634.47362-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0190.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: c14e5bb7-c880-4627-fe6b-08de0a983812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wYLD3IAePDCUt1X+DpFH9s1g08pHHVJNRtaSlVzb2SzIp5LkxUzoh0wv3bEa?=
 =?us-ascii?Q?vxAsXG0qcPDSne3c2MGLKVBz74v0ymk1V7ojbegQBcOEcGn1ocw2b3JBkcCV?=
 =?us-ascii?Q?Lz4K9csbDEnahb9ch0Ea+Vaqle5gALcdf1t+ay+8qG2u7WcFbh1D5xMqKo3n?=
 =?us-ascii?Q?e+57XSGBDfHAwrN4Ag9aFbeULjB3YNXoeCmHGwtcs6eBoXXk89JtbAAUfOGl?=
 =?us-ascii?Q?GatuBsvE+OvI0ZafWf2uw8PEzNgKB2HYklx77f1ynm0YrUsE5uJLwBAjG+jq?=
 =?us-ascii?Q?mAS4c0C4TaHv7umOghw/L9qc2nm31JGnyy6DZXawFQP1m6wdpQb6vhvWVyUA?=
 =?us-ascii?Q?4zeCsNvtY+MSsazNb2oH5+90ex2p6iKzjosBidPGd7q/k8w03MQD5V+GnSlM?=
 =?us-ascii?Q?zawT/haR0L+LAF4VINSC1gPsc//XvVf6IrMn5BbLUfGPT2fDVrdw4D1BL5WT?=
 =?us-ascii?Q?bUCu9i4L/AChEECFaD2aOYyFa3MHiuaLf0aCuXMLt/zpL5GFJhsUiGojNglM?=
 =?us-ascii?Q?+RLALhzCTNAbZJEwkaYKbUjzXZpQkJoGYyG+vF6uJeS+QRNkVFvIUHAA2Pvo?=
 =?us-ascii?Q?+msPPM989C50tiToSlgICdgR1p/4InwIP1HyWP9/cwJOI1f8WhgrbARScOdS?=
 =?us-ascii?Q?dZVGGibYzFIsHRfslOWaphzpEXP3DEKTDcmpfpV5vMO5IeqOxBaEC3+OWK6D?=
 =?us-ascii?Q?Ons06g0C0MvB8P5YEu3Pi5QSnrEDsZLx8SWik7qWJjEs1cDRIpFww4loOfAZ?=
 =?us-ascii?Q?XPWOJl8LUwP90zbe8HBk9VcUcrneac2z0H4W4OVj8nGiKIWaaJluq1SBVRwm?=
 =?us-ascii?Q?UaK1qbkkHrye71/d4bfCT5/9LY0ye/C1CQvgj4E8UBsj8VjsscNq2kHJh4Vb?=
 =?us-ascii?Q?W49k/LTnh2/Hze27wztrx8PCNQrrFR529imQsrcAmgllOHlT1jxY5H0Ht+Xw?=
 =?us-ascii?Q?yBYPw499NT36cwDxOYcfBc+/iI6L0JHYbCZyiCJKvHJxYEqBsNUr3OVuVKB5?=
 =?us-ascii?Q?u0edBvmnlxv+kxLKw682AKL9KnIGHTxcpiOlNWLT4KHTcFzD0TNfF+RYYaLD?=
 =?us-ascii?Q?4Zlfmeuw4HUfMGYjHGL4pghN+KdISEBnul8qaqo0ELjc3GNlI6haq7gRE6AC?=
 =?us-ascii?Q?PgMG30uGKHNkNVIughMv0L6x37GCsJzNS3RQjIFyxf4REb39bk6eL45+iJoK?=
 =?us-ascii?Q?VTVWsJKjnUVv8NeE7GdX9XQc1fbxK5ICjo9EVXJNwqGvRmPwt4GJ8qb2V3b5?=
 =?us-ascii?Q?obc1uqKhcMIqlMcreuhbfUQu4nNaEQlmiYD+STxXNtjvU4SZP8SvhHBm9CQb?=
 =?us-ascii?Q?FzbsDKaqilXVa7lQ8xxS29tOKcf9JQ4OLVdvvNgziwn2/bk3Lv77CN6mgNQI?=
 =?us-ascii?Q?1TXf1U6C4AnFmd2qWJxaZosC5waHlN1Enf/ECcTA8ahrUyaApZBKMd+dCL6W?=
 =?us-ascii?Q?M2FoaR46Ny44QyCSQFWKV7dttYajos3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PF1KnwXOhHwj29RNJrDApoBsDkczHSxMTLwURBqixZbSzrr7fq1e+nHK3EFO?=
 =?us-ascii?Q?+PuLimMQ17GnqfsaqPKqt7iVvBGWGlJQNn91uJs7Vj9pnBNDwBUMhTog5CTC?=
 =?us-ascii?Q?WSQ4504OELMCmCv35UIY6O2fISh+bFoNRJnXRUTUYK0EnwvaXo06J27/iyQq?=
 =?us-ascii?Q?4OYSSgGre8XCF5jWstPASFDAVWp8l9XI+jNb5JQWKA7wFIP7d6ft6bMvRJUO?=
 =?us-ascii?Q?AWxac3pe6PNi94i7af5HSy6vyc3esji62tiJUh9uDWcZIScNFsMAZ+gKaErE?=
 =?us-ascii?Q?hxgouUvpq99cceLY00Iy+qBLhScyLGskl+mVsfXTUNcHZbVYeJxy2clpWMf8?=
 =?us-ascii?Q?0yfGQbzKNxEYirlaGCO18BHmNhQSeyqUt7zPtDb5gKvxxBuckVFO3hLEAgOA?=
 =?us-ascii?Q?6rgK0WNKaJr3xybUwGS500Gkumf7DiNsAFou41cGsKHeWZcebq17in1qJjUf?=
 =?us-ascii?Q?bkvjnSbw3jTrrSM9yzo0b5em4+72LeTEvmHVrC4KGHL5BHxk6CvdBEpl92fu?=
 =?us-ascii?Q?sc8bAxPqIFm21Dl22e2qC47KWwX3jvs3e5ZPmJ7spQWbjZDghSGfsZJXG9zW?=
 =?us-ascii?Q?2oWB8vyOC7P/Vcx05OXgDQGIEz3mmiZVaqeI4Fz8lFMtK3589RnQn+ZdpG76?=
 =?us-ascii?Q?ICsImLbLt4X55k0bm0tW0+z1ilbu/u1o7eFaaukf2YruR1Gf4CQN2Iglj3h0?=
 =?us-ascii?Q?MK5iFjypIbEfIJYZl8jIrZl8nyp06Ta3M/JQriVVHocWqVMKuLn7btlAcEyk?=
 =?us-ascii?Q?v4ayYIfCOuhaRt/AhMD58VuVC3F9xZnMs8f/P8fidFA91Lx3wPqS1tlPbRpt?=
 =?us-ascii?Q?d59PL2IIG//q1zoSRiOdzk9mt7D6D+oCH2ZNeIc/qdWlfBn9d2hbm9qbARk2?=
 =?us-ascii?Q?IbHL2doI9ZcKDGR44ohROYjiExM3ZwSxehwqSjgeN3+ByRG/KYVAoJXNl6gR?=
 =?us-ascii?Q?S87dFno4Hi/Ce583kgfZTneHa+TGyyDwZSgTaJ8S4KZtcJwD8rPEVuqQjmt/?=
 =?us-ascii?Q?aYCHACWO+csv/Zl2F+GLlK/e8PhwWbmY8Nz8AUW1GI0iBBoGJwGRthBLluhn?=
 =?us-ascii?Q?0bamIL9V8Be8e1UTEG4CRA+gU/c34B7tadICtRUKJ48wQ5vGBeOJVKbxIVx1?=
 =?us-ascii?Q?tLZgj0RdqSLyy9yPOAGWQt8hGLmMZ/idKxNn1sxUONvCCWVnUyN+/xZWCyZq?=
 =?us-ascii?Q?GN5Iu8ddbbdkS2pLhcj48IhRmMw3vFsZDyw4mdVgir6DzWt9+jV94KC1YofO?=
 =?us-ascii?Q?k6uM3KLPUbeWkH9RoF8j1Y5zF7K3zaqJp3YlAomwC0dmt03XYbpFNQj8CuPy?=
 =?us-ascii?Q?dK+qKr0faWJ/4ERebrSODjFk+QYy3tgnduOrC+8cBx8A0SqrcQHoN2AC7iV6?=
 =?us-ascii?Q?llPFUNfSZ1nPr+t5SLPKF9zp2SXmp9ElxKuyyRoah7OinI8Y7RnpVyKKLIZM?=
 =?us-ascii?Q?D3iOf++vzIwYXz3CPXxhR09yYjT7ruW1ZSToOrtgH9GetMHzFxyYx1IqpkKM?=
 =?us-ascii?Q?vJL1E/xGEA8hJEbVnvHJPFz0EhvAdX9uJYYkyABxcxCJxUKDFnbew7FxuFOK?=
 =?us-ascii?Q?FVjW1jDrtujKqHyb43Jy1JCFfIAQW0K/7GFC3+OE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14e5bb7-c880-4627-fe6b-08de0a983812
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 20:36:42.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJv3sC6yyw7vrA2HKUN93jnd5MIll29qbEpn+pIi5lTfm+0xYEgc6GztxDEbOK/euKjbjIOW7YPqw0k2/asd3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575

If we load a BPF scheduler while another scheduler is already running,
alloc_kick_pseqs() would be called again, overwriting the previously
allocated arrays.

Fix by moving the alloc_kick_pseqs() call after the scx_enable_state()
check, ensuring that the arrays are only allocated when a scheduler can
actually be loaded.

Fixes: 14c1da3895a11 ("sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c645d47124e72..12c9c35956926 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4577,15 +4577,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	mutex_lock(&scx_enable_mutex);
 
-	ret = alloc_kick_pseqs();
-	if (ret)
-		goto err_unlock;
-
 	if (scx_enable_state() != SCX_DISABLED) {
 		ret = -EBUSY;
-		goto err_free_pseqs;
+		goto err_unlock;
 	}
 
+	ret = alloc_kick_pseqs();
+	if (ret)
+		goto err_unlock;
+
 	sch = scx_alloc_and_add_sched(ops);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-- 
2.51.0

