Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD833B6F8
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321497; cv=fail; b=pQpXGfE+qQRaP6YgLRUJZmgdbmaT7Bj4e8aMe1pNKcLVExwAJd92K6ORW6Z1H//pi6QPjPB9+dMya8RDM4mnni2bXvzevZlN2b9B6iXdbNGaqlbJZCDIgGS1ymueQ0qVTbiIefWL/n5hPEP4SqWqMD2FT2XmKK3spHycDZ6fAcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321497; c=relaxed/simple;
	bh=RYjusGBrczi3P6IWYvus6K7Yq5zCPSIxbbZNS+z7HWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVLsmSXyX6RCPSODhzjEeXkTxbR+9HG5D+LbSCOPPf6sB4yJKL7KHwG9PBLZfTjkFmXNreZJEuuSxxgEI2n6rx5XYEyi6+/ROx52M4GSmrcWzejWcIYX3L6mpjzTzT7FvdlmVTBY4HVymvPqF3P44HnrdEvyBHbhNJ/732/i+yU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiETahFw; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiETahFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHDJfPyQYuTs4vI1FKs81PuKfBtZIZWKJ+mQ5MnEi2HYRWaGKQ80TknNipm5IsNul5QBEMen8ZsJpS46t6f0b7UxJlCNANsOdlZH66zJG32gCuJkiC1XJ/Hd+veLwKAPOy83TY67QbFbaBP3C2bWEcl9Rlekcb9Crcda6LsB51zCRjGGhg77uS+AOjWf1adzpXHlY0niEHUSpJMfVYQ88ydV6Mpd26SyyiHJIg1Qt3ksOAUbESfs6vnidL+NHi2j8ISSe7zFda4F77JeeHx6Zs23O2mO1rnyZKoifukhTH/xFKzPqRkSgWhbdkN8lBB7/8yOOq13cDAB8WW88Yp3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x26ButQarXj/j99Gjh5zSOpfxdhUO2v4RH1h5h7yKmU=;
 b=UKIS7bi//W14DSK8to1jAvfpU/sxYdaMCeXX/7iKGdLu85vHICuN9jWcSm9jzHykiUL/cUGK47bW/RlNu3g2KSY/9ifFAj20lYiSTVpP/G4pmtIqlK2kr9M0PsWW+O9rKpd7g9DNLj4kF8YjeAILnffv3Q3IgyEcQMMRBgFntMfaRkdqx/a9tEqmTLZSTURKXLUIloQJRBQ61jxhwxjDPd4DiHT+ZHe50em4d2QDR4HcK+/PmmSdUK5K2Yz+A/WDdweyfxJtAzKYsNsG0yBdVqQfd//w/3dh/fTtyG3D0U8Ka2G0ClpSvZd+ecHmLTsDfnupEgEc0EE1XpLET9v58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x26ButQarXj/j99Gjh5zSOpfxdhUO2v4RH1h5h7yKmU=;
 b=aiETahFwToTLeT31sIKP0/A/ryYsZI65LVSp8KtkNjyCpqXYk6IT4uM8tAGtzw8UiwMTZ7kPtAwXBHOtB21O3JIDD3rzT0x7sLF5uTaQGeiQxcy7MiTzAEWAeELXvC3oI+ZD4fqRR4df433SMm2JLP0BIy+ruQS4YZWb+WU0bGiXGjOcikrK063dkQciqPlmzTuPGJgjlvK0OJRN504mhNY5LYwkNDUJssv8jXdnpn1ICvmGt7vHAXQvzJ8/4rZG9vq0HkpAvZbBYmjixUR+Fq/+EbHwx7z9x+iNJIz2uBnVMaK/VqDDbjcdlRzQ6IscTCvP9ZPtzI8gTZOEzNv18Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 07:04:35 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 07:04:35 +0000
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
Subject: [PATCH 1/9] sched/core: Drop mutex locks before proxy rescheduling
Date: Mon,  6 Jul 2026 08:50:56 +0200
Message-ID: <20260706070410.282826-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706070410.282826-1-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::14) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: f8870b97-d39d-4018-9d2b-08dedb2cd5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	aNp4U3IjrHF53nIPw5hc5ev8hyhVMLtCq4ratfhd+Co2J2EAU+nX9deW3qs6Jnrg3rjTseWvvCM80IDpEKTcpO4b7JUV/tdfZTVLgzg3ANYtwwW0E5JzlsWcaeKykdLr2o5yv8H6yF1nXnffVM9OdYNYdcqV5svLT8P+nKa6GKea9QX6pZddtFvFOFlO7ukKyGOYiBhMi+UmN9wfW5M6XD5ZyBqgYqfu6EChb+PJLoYl2mf2DolPt+/7ab+fez9iLt4UEliLKoQ1vbVCtd0wubUGy5k4vqKL1CgOfBQ3OTo0kalDbO2KfQxJNfVRm+xfaK/RHHOynhbNFPDseg591rs/IndOSI7J1iiTON2/YQQajI+pHL7ZUdIYXTEwKf6xIfd98h/TYdtu5f0Vz2B1ssAwqIxo438N8Ig0QrqJfxj4BBh/Kw82uNruaXqcBXYub0kuQb8ZHUtfewVzM5fQZdEOQqVIt3rrzQASQLKfhUrICbcV8i59fpZmSmkAKLbqDd7stjWXoo9N0LDo5CMcsCxy86ssXyDjupoee42JbIHgMlelXdizoOWjdYghOdNtCclYjYpqxVtMovWwC4ot7m9M97Uyji1bQimIZmp5ehR3zLWL/Vt3CyYokCjCGprb9Qg8+rMyRSg04yyVGmBNUfL3/nB6ce4ZqnmZwJEs3u4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tEnwbo8vxJYKly1BDbgddel6cRpnvteqDq2LieLZuTdG+TVpHBsbi6zw6amj?=
 =?us-ascii?Q?lCCez/4exNGM0vo+JJIcgIHeRUFq9kdsU7uXiJoXUqb5QhoaKT3odoBXYzNu?=
 =?us-ascii?Q?N2jytt8FSgmpCyVQeku3pWtUOwYaOb1pXrim4v3V9hoH2M/eybTUArpFZt/x?=
 =?us-ascii?Q?AlbjuzM582+RzJ/a+ECv3Zwf6ZnoVbu0pcukGqz/FF9gBD7IzLz9iifkH+sU?=
 =?us-ascii?Q?QjZg29n4LQIvOkjxdQFlmqELVYw4Ll6U3kf7+Dbmmne+Zf97IYsXAohkZtA6?=
 =?us-ascii?Q?SXqFz4tXMLr7ZtkI/IVSpNsBqV1s+tbEgIMEfFHDo1IYtwQr4PCMAaRPsI/I?=
 =?us-ascii?Q?xJaAVmdfEytI14tdGCz2B8Cc5RXNGSbs7ykqVLTSdo9I08Eeh2KzbdWzPKEi?=
 =?us-ascii?Q?oBjaE/g7kAW/uZtyVZtQM4QMuYdyY0po3SHIhwuNSYIdFtfYu+vbBnLj67u7?=
 =?us-ascii?Q?9rim0Gltp/PQu2/bm4HW6LsahoqwbKTsBl2RAhv2Zq0mG9OFv+ExVarZI845?=
 =?us-ascii?Q?4gdU2HSy6VWXqNVwH4l2uktWhzhnP8gbOwl88Rfq1YDaji7XIskr4bP2PLb6?=
 =?us-ascii?Q?vlzIvkQNYpZXt/TXOeCKdOzziEFm8+ZSyOhHgc6YceYf0HZl7OtCv10GuVbr?=
 =?us-ascii?Q?vRfSSyCYLtTYVoP9n/g7+ddF3DCn9K/9jLjrMFW4NFZ4kjHL2ohIlNUNrpMK?=
 =?us-ascii?Q?qOycHbKp1arvMRPEO/cZKxdk8fIlHIxe48D8ohkg8u6/bGYtqb67xgesCfJW?=
 =?us-ascii?Q?ZMKhqD2Qp7DrUS17NMv1rf/yMSfGgQ295v9IsEu969UX/aRRstbOAt3qpyEY?=
 =?us-ascii?Q?KyyONzCj5C2WVQF8G2hTUWzY9uLe/21anZQ9Q50TOUksUBUKv9iKfJ3D9m7B?=
 =?us-ascii?Q?BXVucKw35HnrfQ3NDHMU2rgBjiTJVEQHmRc03wO2BlnK81T9qUFXbpE4atjC?=
 =?us-ascii?Q?WwKL807ITXGWTor00/uVeu8xCH1NiYs7cpBurwkbmgXbM0uTqEECGPVGnsJY?=
 =?us-ascii?Q?wmSAoVmrRR+YO8LD86DNpVvCZ4b/V64Fz9EwwN7kzaLBdAi1Ut+vAg5Apon0?=
 =?us-ascii?Q?0Fy4iBo5HXAHR00Q1dD3cU7Y0mQI0oGMJW4VBrcwLu1JiIlChC55nr3gseny?=
 =?us-ascii?Q?1zq2iJO9Pjq1LzQ6/osn1XGmWtSNJNUq5ZiltnGum1BGB+DbLQta4XycOOxm?=
 =?us-ascii?Q?ty0Y845EgeuWNNyIsN3Jd0P25GZ7EGQQMAKy3VfxUPCdCYv79ttZm7NqvSns?=
 =?us-ascii?Q?un+HCchh00Q9iMrlzqPji13C2cD0GvV6YTkbIqDlobagIFcbhilNOxUZxBx5?=
 =?us-ascii?Q?IojEd1aAlRiO8AlDpcerGH4w1C4Z3ZmZGeWPxDqQti96AWNEpsKYq8+8w+zs?=
 =?us-ascii?Q?yf+tWEqPTj8wDL2zphx0Gea1j+4FwNqsJJ78D3cp0PbTQxaWSCjbO8i0JHfM?=
 =?us-ascii?Q?63wkNMo+tGksUr+xZ5I2BTzyLe0CXheQA57VUgYjVIY+S4mo61xojGcDn7gm?=
 =?us-ascii?Q?uUHoX4ZB4XWt+rTkVNa/UvczHZS14tojF3zA+g0lRXR+BgWrVGL/Ln/RlpRc?=
 =?us-ascii?Q?RqO59zhZB8CxxQUK6zfrAINa8tSEfbO9jtqW3pEW5HeAt4pr4Myo8X0A9gT7?=
 =?us-ascii?Q?kWfdC3RIO91leYb38Jxyq/dB2Cn4ZbjgWVjfsNjc8WxOg5gyq8ALBydKmM1m?=
 =?us-ascii?Q?Oa+07QOq27jlxU53xHNzWp2XXVt4wl0QeX6ijcBS6OKdwKkN/9qPY8uFGTm5?=
 =?us-ascii?Q?bmTyJeAK9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8870b97-d39d-4018-9d2b-08dedb2cd5df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:04:34.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl3pnV4Mv/sGtP6HONZCWSF68LTPSWTaHlEg9Lz2+zlOwnO3MOennlRp4nW+Z+rntv1WrGh7Z5axDQFHDrdXNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

find_proxy_task() can call proxy_resched_idle() while holding a mutex
wait_lock and the blocked task lock. Guard cleanup does not run until
after the return expression is evaluated.

proxy_resched_idle() invokes scheduling-class callbacks through
put_prev_set_next_task(). Calling those callbacks with the mutex locks
held prevents them from safely inspecting the proxy chain, as doing so
may require acquiring the same locks.

This is a preparatory change to support proxy execution in sched_ext. It
leaves the guard scope before calling proxy_resched_idle() so sched_ext
callbacks can safely inspect the proxy chain.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..0139cd4a8be7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6923,7 +6923,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			__clear_task_blocked_on(p, NULL);
 			goto deactivate;
 		}
@@ -6935,7 +6935,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * and leave that CPU to sort things out.
 			 */
 			if (curr_in_chain)
-				return proxy_resched_idle(rq);
+				goto resched_idle;
 			goto migrate_task;
 		}
 
@@ -6948,7 +6948,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * case we should end up back in find_proxy_task(), this time
 			 * hopefully with all relevant tasks already enqueued.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 
 		/*
@@ -6985,7 +6985,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * So schedule rq->idle so that ttwu_runnable() can get the rq
 			 * lock and mark owner as running.
 			 */
-			return proxy_resched_idle(rq);
+			goto resched_idle;
 		}
 		/*
 		 * OK, now we're absolutely sure @owner is on this
@@ -6997,6 +6997,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 
+resched_idle:
+	return proxy_resched_idle(rq);
 deactivate:
 	proxy_deactivate(rq, p);
 	return NULL;
-- 
2.55.0

