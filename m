Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43C34575D
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968609; cv=fail; b=J+J5gL7tOcCwfHjLH8JkQUgbPRvXJq3l2JGe8JA3wIvU4dn+8pVSh7DFvuAYuU7zIlN5leDu1sTe+NTCgnMqJfA1xL+VY/ADNDHynPCjZBvanKyBqG6WJzws1rQayOoA2aixdCHLHKHmz+Ft8s8A8qQD1HOlw4hNdlZTRolvRt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968609; c=relaxed/simple;
	bh=xVdW/ju6M2S2W6Xt5m0Nk7bqm+eunAy8jwNpuswkwv0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S7W2im3pYEc7TAfk+J0z7QDx1oHunrY4QiJiox0F6SLyX9Zk5YwtH4AYTCcZhPrlxEWgMNR8YsxxXCQ6w6pCdi5rEs43SybTgT1yrNLbQZkiAZaGpY3gq5i911CzMMzBk2R4VveccVhqMMLmM9mnTrXRV85G1Qwr4/1HzDkwW68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DpaMM+iO; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DpaMM+iO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMBvIbOoygi410EU72fVbo/h5ULlZfrq9zUVwjdRkaboXUtuHG5rEZS3qcKrwNjv2L9XaItOCf/auAXLHEYY6H4oRbTNjp+4kw7xdKDIX9LBRVDE/8c+g6Ka0Fh+TnS2t+rJmWIgJ6U4qdmSQGTGIADsMf5V3sqoMINkuYV7Cqh9KDakbQpuYZOYOo3Ca/ofoDfM2xNEgdetwpfUzO6+QgaL6IOqXiUECriH/FflEjfhM5ts1jyfUfPQNq1tkeNF2Q49vueo5cEVTVqjWP8kC3Sm8WggpMoggTLrvV6BdfvjyObimnl5IgZQCOVonotbBhXxR5MX3W7R0zN68PVo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USLQNf7ov7Ud7GFFqT79t0YCPGWt3tJk/9UDShrBEDE=;
 b=AONonaJ13u7FBHTa/EwqwOZZjLIJWhtyMftyx+kN8k0J7c9Gz2yrlfbxhywQI+YEAzLA6RJDR8WWTj+JoS+uEaCsf8V0CcYwIzJr1VZsuseajfiwR6dO2SWN3RvjIPZ1p5UmWilYFmlChk0upi7XZUMomVoCwz6JKqaFZ++9goMVU9XonV9v3FpQ25NtvRGU+6QNtZno2SD539zc97Z660Ma4HGgj9kN1mhn5hOuqXmRedykN3lsQFldn065i4li3WnK8JfHQ7747IKdDuZsEuPXwTyQxA8t0phKONlMD4+LakYFzQFhk9iHvo4CHtrL6YZ6E7+dwnIB1OQYTJaVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USLQNf7ov7Ud7GFFqT79t0YCPGWt3tJk/9UDShrBEDE=;
 b=DpaMM+iOkvxf7ZvNzhollyojXAYYnH2N5g1kTJsw43xHFxOazWOuclODzGjtWV42xNQSrhD6dOLHME0VgxDkEIVI79+Ddt4C/oJnHAVMEJurFJVUaogONoXPWWyXiBfJfdkLh1dMd3ExUWlq7g1DoWMlu+fh6GGHk6rit99AmSpKtn88WF4Wtjnp8JcYtJUHrK+ZuMBPDre2uO6A44xh87Rkj85EdiSQYoWvaBZ2CVtU3S6dQtOcUahuMus2afVEBXz7mL/SscMrE5iZWar7xpOkcm8MujCO9tyPr6iT9CCeD8/m9KWBIJv86Ypsjd+NuXb9uTxXVVUhSFBOeRpOHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 17:29:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 17:29:53 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Update comments replacing breather with aborting mechanism
Date: Wed, 12 Nov 2025 18:29:45 +0100
Message-ID: <20251112172945.299874-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: f827e155-5d58-4a2c-ae93-08de22111782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QDltBUQ1T0Ku7ax5AnUDxvN5jp1dBQztaeU2OJYMraArlU/vDgwyYXbWIcYO?=
 =?us-ascii?Q?US3fVZqFLHM/66qPsqRy02XVvDiKTgVHcqdTux1BmyMyGxXPQnt91BpwaZmI?=
 =?us-ascii?Q?jZHgpz4SEUF6ZLOhBj6rtCHT9VpvGCsSyPvFgNio9pcD/x68p5FAILwgdp75?=
 =?us-ascii?Q?pvBPRqQOR0rdI2W5TQRQJGte1mqMSkGpSx/6zpbTJxXebF3d+iiF9XS0k53O?=
 =?us-ascii?Q?22a8wDtaCjR4MFZfNnmjFYG7bSr4jFR2IoGXxEFbh2JNRn1aDPmEDVYysyHP?=
 =?us-ascii?Q?AQ6NB9f+Wv9iaQbXYqtzQKt9Pg8mCLVYEk7yBMKK3cHvcXkAU/sORE+JybCV?=
 =?us-ascii?Q?eIf908r4rbTr/LzefsomMVwpfGdLbl9ifgXqEMskFtu49UewM7dkbBaRmKc4?=
 =?us-ascii?Q?5d6CTEK3O2vrNnHvkuEzMJRq91dZLJsSVNYDP1/CPBnlBsWZxU3QZ4Ah8nYu?=
 =?us-ascii?Q?14RtH9YAOmIXKRJnd2qWbDdrjhaCuWXzicWdzC+KXXfDj9H45atEkgyNV+Fp?=
 =?us-ascii?Q?ibFIzoLVHtAcQWG23TEtyKTSsWI3eLCimkZg9DZ+UW2V+OD4wkeUpBb8vhg9?=
 =?us-ascii?Q?Kbew74r4auIZsflEKmK0biVt0RbUhleiakK2SbY8Cvp765gM9dO5mvF0Sqt3?=
 =?us-ascii?Q?FfGduvf1T7snAJYLi7zoEYE7GoJl9B13CLOaM8oU261+nxyfNFdFj5Dm02s3?=
 =?us-ascii?Q?+XaBaz44MM/323f6PPurXzK86QacHNJo0p2VrvRirevc//UmiEtjBVAz5BTy?=
 =?us-ascii?Q?2JK1P8TMAiQpVhLJ0UDF0Lnirkr2Hr016avL0c8oCFzlmih1/y32BxavSGCE?=
 =?us-ascii?Q?o7JRnz2moRPagyg1p3xmUQ8F5I/udQhnkUgZ8UNsfqXsGVGb1aAgnyjOQCH2?=
 =?us-ascii?Q?33J29gS17K3otIAe4fQVLkbVqz8xuI+uh7kshIyOcaIhLW0lL9muHz0YQy8v?=
 =?us-ascii?Q?22H12Tb/NMOKHRcijMx7GuvgcSS3mBGIC6uC8NSiw4nS66Pc8HzoaZaF0W1H?=
 =?us-ascii?Q?PkeFww5OWzql1i/1MYrncU4fYoqxll5pSIDaNIMkKi7W9TirOvtFh2D+x3IM?=
 =?us-ascii?Q?lDR+JdTTjjLQFjZiBvFkhb6iJjHKGzm6KrOZjpwgRBy2ldSZzj8r2hpeDN/p?=
 =?us-ascii?Q?DFIhgXJVd9ZNilSSW5Giu7QNa6wWbJdEY4QinIy/wzBzcmsU7avihSleTfsw?=
 =?us-ascii?Q?uyPPEVlj4/B/M+vC8Bq1BxXUXtcfGpl+u5X4nBVODUdg4yFvvBZ5ucgF+MAz?=
 =?us-ascii?Q?I8kK50m6ExlQwZTuQpfQRj+r5CELQzAZKeTobO6P512oUI+TjP/WFKuY8v9P?=
 =?us-ascii?Q?ZGz+vMWr8/AyBHUpAYYDfo+5Dedfn/GswBqY0O/kWd2SwnwH5CO4RyAIhrbE?=
 =?us-ascii?Q?EV6oK1rAK8nQ5GZvJ2pfgo2tWdKSsJpigkreH/69+v13+I90x5xiXIEZe049?=
 =?us-ascii?Q?FY6hbBjkZZDhcXi699l5lZPjMKF+Os18?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNSIxF9MD3dihEenGCGOSnBDJrzVgDdiwFlUnLb+lk+ow0TJ+xFGaCsYu2T8?=
 =?us-ascii?Q?ksooZd4Fw1EPQM05RdGCIg9JhdZTyIUg5k5rimkDqAEloNtAPG3z+KfawAIQ?=
 =?us-ascii?Q?034QBJYtP0MwxTP35JxxkUN4u4/V1188T6ohN2O7AdRAyrzC8zAlj7NFRvt1?=
 =?us-ascii?Q?Ej/TNOoRvZ6NiE/72YK/8kXrFEEGPHr8tDhDNu+lkgUMXaP6KDCh4Xlj+VKY?=
 =?us-ascii?Q?aIlTNZAn0I6xliE/C53prpdVMnMai+6hBAoqwFhRQVn+WvID5eg41MsM3FXh?=
 =?us-ascii?Q?R8k809atEiAkmHBuYMJKveSRWV01A62ng+KrttDfMdOHNLO8nIVLznkcSPFE?=
 =?us-ascii?Q?CCA09qjCAybQ8F4o0AY0Ht45FMq9EIwx8vQS5Nlu7WJgnRtTmdrBKmmsFQcW?=
 =?us-ascii?Q?8L+uXTB8iFHbxgg30Ebx1m77k1YrkKrqHCQvMcZhKkLVBkxHf3fbMINBLumR?=
 =?us-ascii?Q?AdbwaBc7eEykOiiHjlhnd8TekROrR0scHulQf37uxET8BWrHbUu873fPLwFe?=
 =?us-ascii?Q?BdUmZoLDrtDMvbSQ81h2IQGKs6w8C+h0HHhMOYwc3kzHVqgEbryXRR4VPFR8?=
 =?us-ascii?Q?tnLuHGRT9d1hPzr9APN/KBGxm2BXh90RJQHPQk5F9FU3IYyN7wq85opjGD6/?=
 =?us-ascii?Q?zsYUIY8S2eJN/Pxf6AyzK7DB+Pl9pSb0ECJrnjBIUeDhgDCCOlYtkFHbeiVL?=
 =?us-ascii?Q?czFVKZSwurGBPW9+/mXGYgF6M66MzBf/B0m9y2flDYxTTZhXwrYeCKQSimLx?=
 =?us-ascii?Q?WB2wNT4JoorcR0U3osW8Ug8Apy8Fn6AY+mF1GuSol6p0k1mL5EvfHFKP6JH3?=
 =?us-ascii?Q?sJrZ56IaJHtKVebbLWm7JYUUNH7JFtxLBM8R1Uzy3VRUkKl2DtH6Kudshgy7?=
 =?us-ascii?Q?g3MeafXGKYkyfUy2xqSPfblbs17u7TjBDDsc7mHO+kaVcVmkYT3CR2PmrgWB?=
 =?us-ascii?Q?2r1hKhFbKlcZQiqzIn9KSTx5p6uBPmfssyrAAqbQVpTcx0AarSEHQMvqxexS?=
 =?us-ascii?Q?m5czeeA+rs80YFaGkR4wLtVMJ+JHkpr0uEROj5/mePgOKuUOxN+5TGD4GO8A?=
 =?us-ascii?Q?l1qKPvpWFBzmhTnxLQqeTR//5SXUnyTVU+/+BNSa+5YBeJSwCtEztiCgHpio?=
 =?us-ascii?Q?f5Kfe+dQtQxpaEhBSbXRnflykQvMmfXaniSo22+XI5sYZiZjQMItsUJSU2m7?=
 =?us-ascii?Q?lir7CoZeIxv3+osjgTHvfaVpGMgNf/v1KhIH2iVS81mocmbGb9IhLfMt2tzi?=
 =?us-ascii?Q?DJBpENnNX8Qaz0WnaPnP8cTNj8G8l6T00vLt+NPMpuCJIvFu2k4O4oY9MrSq?=
 =?us-ascii?Q?ppAaYIlZHB5RhJfaJqV7gch6AGAm/suP/uXACLJHXxLgWcreO7uLwC8QAEYS?=
 =?us-ascii?Q?jN0KCxLVnpnBGDsbbiwonWcJteO8S98Ms75T5eWKQoZ9Me9Mazx2nBnuHH5W?=
 =?us-ascii?Q?5XZufw8IobwtvkLBCKI8l7Ct+D3M9XpoyRFCM7p3Vdos4WCZucC4JlPe2Ma/?=
 =?us-ascii?Q?PfvcvkljTqTWsSVL/PdvKu5QURiQlKOFweBR6loVB4Ve3B7VzhS8EVWVUJ5M?=
 =?us-ascii?Q?9DS5HwzdKpr0zFLOwD/YrREv98QYv/e8B6jKzScu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f827e155-5d58-4a2c-ae93-08de22111782
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:29:53.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RP5MLkpz7eJa4BP52IvT5Pvt9I7QrwNp/MV1GIlMTtUTxgQOLGMIYHCAxWTTLEtSBm+9TDsRk2bLFsWh4VG6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

Commit 5ebec443fb96a ("sched_ext: Exit dispatch and move operations
immediately when aborting") replaced the breather mechanism with the
scx_aborting flag.

Update comments removing references to the breather mechanism to avoid
confusion.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c900667b25b88..8a3b8f64a06be 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3732,7 +3732,7 @@ bool scx_rcu_cpu_stall(void)
  * live-lock the system by making many CPUs target the same DSQ to the point
  * where soft-lockup detection triggers. This function is called from
  * soft-lockup watchdog when the triggering point is close and tries to unjam
- * the system by enabling the breather and aborting the BPF scheduler.
+ * the system and aborting the BPF scheduler.
  */
 void scx_softlockup(u32 dur_s)
 {
@@ -4315,9 +4315,9 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 		return false;
 
 	/*
-	 * Some CPUs may be trapped in the dispatch paths. Enable breather
-	 * immediately; otherwise, we might not even be able to get to
-	 * scx_bypass().
+	 * Some CPUs may be trapped in the dispatch paths. Set the aborting
+	 * flag to break potential live-lock scenarios, ensuring we can
+	 * successfully reach scx_bypass().
 	 */
 	WRITE_ONCE(scx_aborting, true);
 	return true;
-- 
2.51.2

