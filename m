Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945733F5A8
	for <sched-ext@lists.linux.dev>; Sat, 25 Jul 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995565; cv=fail; b=cYObfCiJQQkH1hnVISiClJm9cEYPPw4v/Rv6lngkQ4RHmtpB7kC0ELHyipPG1QGYuxrabLU2KmbOLwYzobp2g1oErx5eoJ+B4ukTP5zWC7wR4T9DkOR9BF09Y1QbeCLiQtgGBL96T5hes32AJorPSnMIuwoxBGgJdKhxpixjMiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995565; c=relaxed/simple;
	bh=dYvXVsgOGy1e+R+/0gJkxjwePB8Jhaj37aXAKSYjBDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VG8cykOFhFu49Sn2Td/soMzUI+GLvyLEsZD0wyTB6sN1J7u8S98kcyZ0l5xpX1WReOqzc31aECvTUOXz+HRsvKD9hlQT5tSON87jC6Ol0caRCHdhD1aoMMMkfUSZi2LYIOfJBAwciF1/jU6LgFmLmHTcageo0NgSQLWJ5xDAKJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2p60O25; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2p60O25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLHVYPUQimkWOghgqg6VjXGgb+3tdBTLuap5ZehDsIq3HkcFk6Z3B4a/1cQdpcOkvr1h1GxkDbmkYVxm62pIEDE8BkVRuxmW+xJstWUKGBEzLAcBSAeMnPBE3OBeXlFXTSY4pm7W8tHhogVa1RNghnno17Z4WmcRKNGJfBQan13vUTWsgye0zfAjKfziwNJIbiZeiCnLLoYpA/cNAdRGdtt9ag1lgF3sUM/XZSAJou4P33xUfduKV0mSCSQa+9SZNwSvnAejlMGeT0aemZ1b/mh41MjU6jboL6l9iMF6Z/XutpY9w+2VR8wvRfpjAMVGk+Lj57H71ei2IUTieunrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gca4tEp1e/rD3wA8RjN3tlWzm8zzj/t+wJ01XdAOKek=;
 b=ocsUkpgwHlqW7xp7LnwXrqGaYEQtmi3iBOMKVpF0KVy/dDv5bYpv7ZMS8cp7kVPTjJ/1rsF5D4fTmQ0hPmsHxa6H5uYpeUk7aU2BXTSV/436B2Gkw+rQtw9CnYEe7cH/DNotW2jKzb+rDCUbcQK2nnC9HDnRIyHLy6qS0clSWO6vOnzyiY6AMEZ8dzzt8bl2V+T2kYeKS47froNuGpA5YTyaADOVXoI3ltROTa8RtbXym4Te9cQBr5IN2lBId0hGH00D5PP8x+UtKEjp6HX4DYNrp0mWy/Wl3vILFHdW/2z0AcdfMefNdX5IWLG2fIjmLIkqtiE8kKtX9kfRNtlhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gca4tEp1e/rD3wA8RjN3tlWzm8zzj/t+wJ01XdAOKek=;
 b=Z2p60O25VkAVV9IMLADZ9IcE2Ubh5eiwybQX7jVwt0v/1+Y+ydSFHstsfvUWTTQ5raxlEpHv82dYf2pmvXGeNFym203rIQ7qrj8P80iH406Cw6SGermP24zIY7y4XVGiSFtFSjHh/UG/p2PSu1kgu4nO/P/iPic0Bb3FdnTeBMYKnp5Pns/sr+W83PYqJ6i1APZmeK6NejYuZmIFoOsF1KaMzLHyQPS3dafQNJDBWr0JvU9JIEi/Fk16SLyR+ulYBL+dSzA15mNBLiA6Rme/ZCROiAHHELsYbzXka3ERq0vCpTG8x5EGx5iDpyWdl7mA/O9mMA6XWwB5FEFayLNrPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 16:05:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 16:05:58 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] sched: Add sched_ext hooks for proxy execution
Date: Sat, 25 Jul 2026 18:04:11 +0200
Message-ID: <20260725160513.57477-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725160513.57477-1-arighi@nvidia.com>
References: <20260725160513.57477-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b519d19-b1cd-4ec0-9ac6-08deea669da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rwfzGW2TGV8TAZijJDyEYMHhr9koFzUwHxSmsJtU2Jkfw978WDTg3+AWXBDArWA4hD597jXDXB4qmnF+XrANmDgWp3jeSCTbgXRZsDsEM1Kc/rn3O12zO8ZKBhSQHR1j5+mmkQ45yE7i6vGzc6SuObXI5kRBkAF7wvpfRTxHMalI5+FFjMlcEOUp6gGgjXHyHdmQpDE+Jid8zN5rnALx2BWRYzr3suIsYEZmh/21yi381vSXRX6PdQXbbuHCcnbfYqzdnrZeHo+Z/ZOITDypcKPKAe/0Q2Q/iv2dIT1SIHrmm51ATGAmvA1vSrHvfIyqb5stReEfBziMUmaNNPt8VkPykRHKPhh+2q1QGja61zC/IKhjlN7o/4KVO43FrdcawqjncFukHsI3dluOdCgnAbfr2FdiuX0W3PsnNf/4havfvfGTDFz3zYjLdvhyyJKcDp2oXzEtAmUZOpAr1TszXn6yc8nbr4ApTNWNLfWfs9VClVgi8fiR2KNcesYSMypHGFrsNKp9Y09UsHMlAQxiSMp+fmQLUK1WbA7y9ZCqT2PH0vxNYEjU9oIsWOfqZzlKHB1zaSAaUiFUcPlHhcSI8fPD8tXPzbaxKMRXRebNhr93knJXB8r1rRlcJIrE1XTE05Cu4LxQRULm7oUNDSA/joDf7WB8V94z5O9AWQCfYrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HrlPqLnPE/C1Wvz2OoNQkln6CJiyUNtSbk8zRXQR0dMdB2IDsPEzZ6GWQI8r?=
 =?us-ascii?Q?L4pmvoRM21bN170BEqnaZEHTvJlRDvtYS1f/0Qa6Y3nZnuMdqNJ78DjU5vgR?=
 =?us-ascii?Q?w0msswZdSr8iUsXWOu5hetkq6tnPa3X04QrqunxwszYKWVi3CwGwEZAx0eI9?=
 =?us-ascii?Q?WFEsoOjar9ILeHtULxNbg+iFj2I3G5y8VSFYQ45VfetkSj9oJ8ZFWIV4C4C1?=
 =?us-ascii?Q?+/j6awdrjeoLCyK9abUBywaUpgPPvRra7YeYE0gdS2bk8kFX/Zf6x/RaS0tn?=
 =?us-ascii?Q?oUAUAEUQbPo8nPUT/Uwqarq5rYUGy+b5xTOD79N0HZ/4eWGvZO7HO6EvbjHN?=
 =?us-ascii?Q?f2kyF4h8cYyjdhi3b/C4NXPSlIlteOFTh7OR74mkydJy56oqLs4UrWpQ0e75?=
 =?us-ascii?Q?GQdtdHSLioKvEkjSos3opg9dBj4Va4MjRXsoS0jlYkL0C7fvg0Cr+HfC5Zfn?=
 =?us-ascii?Q?uWAN0ssfKQlOt1c99TJB9klQDQFr1rgxq0ZfvsRKvvgon3MzIzl+HtzWSlVQ?=
 =?us-ascii?Q?rbkl0dji/3KMX4uMQX6lyK4RCVOqhsgxQL2zaJ9orLBKBKRpuJRZf2f7+dsE?=
 =?us-ascii?Q?IMUCgu8HYGyzuw/sxJCaOq122zcARWwRLOvZsnda8+EufRJv8Cv5dplXojUY?=
 =?us-ascii?Q?iwvYsujaEgmXpxoHEDiIXWOWVX+5zgogJgTtIFDmIo/wxFv9RytB7jANnWcD?=
 =?us-ascii?Q?BBFfIv4dBl1J8F58Qr/6bKerHdZULMkKeLkbl8z039Gnu68okzqES6OLTRHy?=
 =?us-ascii?Q?oaoja2x+uxeNU2UaKnjoIx1B60TwVc2hQGgixXk8E5wX9b3yh7DJoPtf3adl?=
 =?us-ascii?Q?zGc0Q1tQaeJaSkHiJW6LQOEzbCcg6ke6mLSqkXKK9fOgNP8j7FoBU7IZnQrF?=
 =?us-ascii?Q?WblGV21H5J7/x56BSosg/DoogxwagMluZOnp251/hMg9YAeattjfDc/PBTKe?=
 =?us-ascii?Q?nhjLHwOIvadokuWvUzGglPl3I14LU07byrGn4wk1JqsrTaEpMyCZNnQ0L+at?=
 =?us-ascii?Q?S/AYdDIVYT6XrAz0h6bu2cdnDfTK2wZAYY/8It6U0sqPrHuLl1XK7Cua8bCF?=
 =?us-ascii?Q?h4qSm/gApHkfyNVdN3fzv4juJLk9BGhZIacE7Ls18hzHczYVY42b3O4OyeYp?=
 =?us-ascii?Q?+zkyq5vDH4tXWGBv/x3uNUtDK7jETerxuo9xLXZufHF/GHnn1EPozxl0/pvz?=
 =?us-ascii?Q?sp1kHPfly/QA3+SNCzEm6gh2+hdKNyo6O+UxTwrIecDZcY/BjJM+dw/tgWU+?=
 =?us-ascii?Q?iVHOYIg1QKzcLffkDO5I715g1OsVcxeA0OHxfuPHQvfIx8xDriKj47AbvxJu?=
 =?us-ascii?Q?43awE+iRAUcdWqZQx8FA1PI8sUrS4e62TKRnlJO/R2p4D8GLB/rrYM17yzJ8?=
 =?us-ascii?Q?opMwIrP1gfcXp+dJ9+Z3VaNEmwWyCnCVOc3ZCGvucuKHGrVyy3lfBVglnsEk?=
 =?us-ascii?Q?7zxKztsqx1E5lblaQv2Zb+kQgweFYnlro+AnzZIKjmDjW4ZfYMYxCx69yYNI?=
 =?us-ascii?Q?J5leMdhKz3692Qg8k0lzlKoas5nBB9SU8+Z9oQvNzjbVgl6DfjKhEQ7zK2kB?=
 =?us-ascii?Q?RqczvG8AnNo/MBHgEcEbGAB9rKQ8ggWB5V+6z1iqehlRQ3aUjXLYSpFq3x+a?=
 =?us-ascii?Q?qpw8gTbZKRY/MNa0v8dE9xnYpveOPyrvi6kzzxw+euSsJWg6nry27nL/a/rJ?=
 =?us-ascii?Q?b+xSvuBIysEpTE+5WbnXsfR7EaAesPCPtkeWW7ykP6fHKSKODY5nmFHyFivk?=
 =?us-ascii?Q?KUSX1LbbOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b519d19-b1cd-4ec0-9ac6-08deea669da2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 16:05:58.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpTbZhBIwqVYqnEhwanEk+4z2ZydAPrgrogqB59KoEiU+Fivjx7vnaK+eMG7HVBuutxxCsEe+QLSYye/eIes/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

Proxy execution splits the scheduling context (the donor) from the
execution context (the lock owner). sched_ext needs to observe that
split at three points in __schedule():

 - whether a blocked EXT task can be retained on the runqueue as a
   donor,
 - when a donor's scheduling context starts driving a lock owner,
 - once proxy resolution has settled for the current pick.

Introduce scx_allow_proxy_exec(), scx_proxy_donor_start() and
scx_proxy_resolved(), and add their call sites in __schedule(). The
implementations are empty here and are filled in by the sched_ext
changes that follow, so that all the sched core changes needed by proxy
execution stay together in the preparatory patches.

SCHED_PROXY_EXEC still depends on !SCHED_CLASS_EXT, so the new hooks are
inert: they are compiled out with CONFIG_SCHED_CLASS_EXT=n and
unreachable otherwise.

This is a preparatory change to support proxy execution with sched_ext.
No functional change.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c    |  5 ++++-
 kernel/sched/ext/ext.c | 13 +++++++++++++
 kernel/sched/ext/ext.h |  6 ++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 474628f520a29..2018c4eb680a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7169,7 +7169,7 @@ static void __sched notrace __schedule(int sched_mode)
 		 * task_is_blocked() will always be false).
 		 */
 		try_to_block_task(rq, prev, &prev_state,
-				  !task_is_blocked(prev));
+				  !task_is_blocked(prev) || !scx_allow_proxy_exec(prev));
 		switch_count = &prev->nvcsw;
 	}
 
@@ -7190,6 +7190,7 @@ static void __sched notrace __schedule(int sched_mode)
 			}
 			if (next == rq->idle) {
 				zap_balance_callbacks(rq);
+				scx_proxy_resolved(rq);
 				goto keep_resched;
 			}
 		}
@@ -7210,6 +7211,8 @@ static void __sched notrace __schedule(int sched_mode)
 			donor->sched_class->put_prev_task(rq, donor, donor);
 			donor->sched_class->set_next_task(rq, donor, true);
 		}
+		scx_proxy_donor_start(rq);
+		scx_proxy_resolved(rq);
 	} else {
 		rq_set_donor(rq, next);
 	}
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 285bd8422193d..c7a77cc914cd5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -24,6 +24,11 @@
 
 DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
+bool scx_allow_proxy_exec(const struct task_struct *p)
+{
+	return true;
+}
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -1056,6 +1061,10 @@ static void schedule_deferred_locked(struct rq *rq)
 	schedule_deferred(rq);
 }
 
+void scx_proxy_resolved(struct rq *rq)
+{
+}
+
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq)
 {
@@ -2928,6 +2937,10 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 }
 
+void scx_proxy_donor_start(struct rq *rq)
+{
+}
+
 static enum scx_cpu_preempt_reason
 preempt_reason_from_class(const struct sched_class *class)
 {
diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
index 0b7fc46aee08c..859b9261a8a6b 100644
--- a/kernel/sched/ext/ext.h
+++ b/kernel/sched/ext/ext.h
@@ -20,6 +20,9 @@ void scx_rq_deactivate(struct rq *rq);
 int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(int policy);
 bool scx_allow_ttwu_queue(const struct task_struct *p);
+bool scx_allow_proxy_exec(const struct task_struct *p);
+void scx_proxy_donor_start(struct rq *rq);
+void scx_proxy_resolved(struct rq *rq);
 void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
@@ -54,6 +57,9 @@ static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
+static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
+static inline void scx_proxy_donor_start(struct rq *rq) {}
+static inline void scx_proxy_resolved(struct rq *rq) {}
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
-- 
2.55.0

