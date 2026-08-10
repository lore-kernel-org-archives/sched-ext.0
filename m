Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843D41F7C8
	for <sched-ext@lists.linux.dev>; Mon, 10 Aug 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374992; cv=fail; b=MuuAr2tqI3vH6HxqZVnYsKjcc/Y7ZA26ZO+2r9oppgj2I86ehnn5qAhSdBmTLSW0aAc0ycR3ZktnWYHpTAggyAx5xuTAr5JV7f1beitVvJisv35HepWTwKYWe6IajnWC3S5BcMbGneoOZRIkZKcZJ5x4vYjtycOOWk/SZxVW34c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374992; c=relaxed/simple;
	bh=HMyFE4NnGtW0/PoL6t9BONe7KxYT/o+iO25nWr6XKls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3bSHordCHnCFF4Mq76IAV3c7hG3wkKA7Z6nHD8BcuRsUG/H7PH2F7XuKywz/Bn8o76QFo05t2Z+IOG1izDDqcs/+z58Ee1Uj6uRrLCQUp9Jo1YteIvmRoMwhhSfYghtXp5r7uJ6p+303IOrbW1aPWtjf8wh8hcqhS+XKJPh/rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o9x2KoXj; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o9x2KoXj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYmKJU2SgfIQ3M8i6wVJ1iJr4NgCsswWAJXLmy3HVDhNYLsKmpucqtTj8hNEukoC6LS1Rz971R9PQa0hWyHaVAg3avtGFow09Vb1RD6GiwIVJmsnZFXJ1xKulHS6ATJ1yMKyxgQniHD/bWp9gVA89AYJ5uNb78oHYKM5vyhLlL6E7c+b20hKoe95v7/IrrnG0g4ii3pvnQDpggvw6r+LXMwo92laR7SjTKpw+uoLbq3dJ5VuyCZ2lXdTUg/+AZWMdp4RLEoJ71dw+5Gs7qvFlJGFDwASKUVlqnRyFCqEB3I+EUAfa74bc671+CnRdxotGfHH2PzsydJrb/XoWwIcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uapRI5axwkzXk5RmHaJjaELwYpnJpS2F7ADVgBrrTU=;
 b=T5Zt5TReA+CfwCVqYXQQcC2uMopyPnWO59ON2msOJ7DwKJ/YHl5g+9zmbMOlfgHTMZ0j9KYIGXO7si5xIa+VPHE6C3wUpzG1qnQ5N0tZykM0O97x5digNBE7Aar4CVkEEBnB9GXYPaDNiXSpCds2hk8T9Xf+60yNvCEY0XxkB3Teq+gUjqmUy0TBhyFGKnzc+sznW1vnP/2RLLvRyoUp6YZtnaxhllwpM4994hnGRNnHvHpheBSkeFXLeKmDuj/fdcYWW6dU0iXBTDMbfDvJtKVSNN0Z/618xk9Blt2rPa36FlLKBt8+9w1nwOyiCo0d8ab4zvK753nTF6B9aJkaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uapRI5axwkzXk5RmHaJjaELwYpnJpS2F7ADVgBrrTU=;
 b=o9x2KoXjSFiDbf8iWugr0ZZQX76/n7eB2A3++vcmlShQSAFhhpV+8zgf1HQBPhw6uVBB1dAG3tF8VdSHD9xSr/V+H8CQl9OxpGIieqcrp4DdM7aeQOh0qxWuCnAwEB0FPb/LFZYA1su6n8I1PdQYxolZo3ozHAfniw4Ef6pcXqXeJimOflNdHTOCR2WbSG8SA2ut6NVMy4VjKsv1Lc8ax0UNnW9uiJEGRQKNTLK3Fo/dy9LcVPeDB1GLlkg19qnb3Q8ve6C9OVtjmzrqOYG83IJoOw56S0EsoHn59M5PzENUkSiFn7Hs/clfYP7/9il7Ta5gnMH21684HjHfBx26Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:16:23 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:16:22 +0000
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
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] sched_ext: Block proxy donors across scheduler transitions
Date: Mon, 10 Aug 2026 17:13:52 +0200
Message-ID: <20260810151523.86994-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810151523.86994-1-arighi@nvidia.com>
References: <20260810151523.86994-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: d776e67f-90ff-4163-d5ca-08def6f25685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UkfQuQuEsp0BwlRe8Af/hGlfOWuYnq+XmOG7svuDL66xkgUUbJIeBkFSoVF6qNwhlzowoMo9bxcBTjWedLIkIN6t7iragYEKKmhi0sbA7Mw38UAkcI7YbYbA7S7xxjdf8/PMkTa94Qg+N1QtWHkP0YDDjUi2T6h/01HZZLscRLGsf4YFG7VFlW/k4ndmlpvwMQNwUVf2M5Wx/zr9LT3yynLoWTvQceTYwc7UQluoYLNL5f/8Y03sXZ9mQP6vhSJZYD9pDH3aGICescswbTfFHMATDn+ZMDfaHbhNdbQXvr1FB479lcCqp0PKXX2J9Gk2wE6NhHB7Ri5LChw+c3JPCYm3r5xB7X5Wc72oWiC0d7pfd4nKtMzp4PaXXEr3HEsCyiyjhIlE/kLcA7hke0+/bC53qjo7ZFhs9vWSRMscqT4ZB8JBNiy6shPaHQ4mIIJv/SFGT0zI4OAd9PoZAQhRATRTV2POMYUVEwIQJu53PZqPvXoNqjfPK0iV7Pk/FPKrbNFXjvF/AxiSicNOPrIT9QOBTZZM8S3zZYBT7jg9QGYgc00Aa1Pa2JMnbS9a4hJ+lqAnuYlDXAwRIR6PRMDlz1fWQq8aAcgw2DTmFD/nwq6iS6jzUfvP/NvbHVTdhcgZRdf3PjP/IFxq50TISIQmz+6Q2OR2ognerRa47vXv4R8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h14c43k/hsKm+vvJE71lGZNdRvOq9Nz3tmQh0pAD7xUj5fyqMjxO/a23el/+?=
 =?us-ascii?Q?VCmfqPOUTMxexKRxHYEBGlTrinsEr7etUxii0hAa1zDi8MvWwRHCRgz6tX7s?=
 =?us-ascii?Q?5+TQ++Ah3OQ0/nKSUS57GLggSD46OPPvl7rXs7WuMQQcgWHk9kGYpaKaFmZI?=
 =?us-ascii?Q?OjexUneIK7vxQjt9JOLomQ4L9fyCAgahiHFzjAYK16ByxZqBOXUkf9yCbm7G?=
 =?us-ascii?Q?iLXM7JbZeWuO/zVmjPwTDRrSlMekoGVBmYbbIE6HvE6g2U/Tc9C9pzxX+qDg?=
 =?us-ascii?Q?nQKSwVeTxOge4N0Si3xsB70luKQ3GeR+q0c+hGw2XxVmZa9KI/GUGRvRv/uC?=
 =?us-ascii?Q?X+tnlRZcmqcvkCp2d4DmGhfj07U0LcRVGmWmxtX0onhvsmEJpMgfSHhKTLW4?=
 =?us-ascii?Q?8yU8WVS9bikoSljDeo9U/j3dudbdGX3/7IPbQXHyuz8mX56IXvBLgPzoV4D0?=
 =?us-ascii?Q?iND84ZGHK33elrDAQhLBFEsX/H2Rs+RIv2rOf1WlueaoWVOaLsUSoQ4Vcd2j?=
 =?us-ascii?Q?TuKYQFkEM23oUzTugmmvBQeiOIiTqeadqBKF9/MhcLC9jSf1V9Ei2t+4fyfE?=
 =?us-ascii?Q?oofACjmqnQDldiCfZ9PQJ1JjneyvnbJw14gCtrlZlwiibbKS2L6L0qx3oASR?=
 =?us-ascii?Q?qvlVmig7zbATsYSK9F5gh3FnZqPWqjjVWaRmhbW+W/CVa9glBLhD5SyLF117?=
 =?us-ascii?Q?HNFuQrJnqVrDDkCiizW3loI/Nl4oVHnIhrKBIFMPRvR8g/BEL+HtV8w4adsC?=
 =?us-ascii?Q?Pq8YmDNC2VRPfQ04QCgugH2nLAJz5wwAFQaY447eJDla8QxSmDPPGi0qGNG1?=
 =?us-ascii?Q?y8tr3f6jsFhAhn/MW4RbEh1bntjorzW0kGK2yM3f4L/EvpntbjEkaWNlmhbk?=
 =?us-ascii?Q?mBa4rCw7zLQ5Ls1TrW3PJxqvRjwoaeEObcMD9r+WIN8xud47yMac1vDGt/mh?=
 =?us-ascii?Q?cA2+jlmVVLEMXEROTlxCgjIr2Nk4bVQsmOMq1YVOwbKZZlc97TGuUfcnc7jr?=
 =?us-ascii?Q?fLWr4QoiW5/Pty8UHpyF2U+/kJMOPrIqEt//PcsvN4KdAmGD62Xx5sx8bbQ3?=
 =?us-ascii?Q?z92Nxbv5qv9KX0ATwCNxbPML0girs7ASf0BcfTw87ytRHLCAhHoxdHgR3QZ7?=
 =?us-ascii?Q?roMGRdNW4d5z99vlDJ9jCLw3+8Abn95TKeZXq4G2F0LE9xWYmQGFFoBo7IjX?=
 =?us-ascii?Q?mV5HtlyEWqoN1EJKr2avcTX1/7bFwQgggbLAgdVzu7CxJvlkDNsO3pKCNwx+?=
 =?us-ascii?Q?nfjp5dh4boQygkGu8SHlQpAUckTAOra1DwaDI/RHK8oqqghShb3SCdC9HDiH?=
 =?us-ascii?Q?Z74FVZ8brdrmEEZRHCxY+azkr2YD46PWxEweYsSrvM1YzYNJ1zfE6qLOEDK0?=
 =?us-ascii?Q?YhtJkmCLGA/cgmfp+oogOO12T2N+OZPm09+3w876uHJfn9gEGC6iAbJ5BG3e?=
 =?us-ascii?Q?R85QSnLJ+Ej0PYJYQBF8wgZ6Xg7I/Cx4OhCgi2sP0roZrQU8zcwM8OVm4Cv5?=
 =?us-ascii?Q?ZsA6nQgOogMGYp8CIWrDix+EBhLVo0v8Ezg1NvrtKW6jD5u5NQvvgxfPaG7e?=
 =?us-ascii?Q?n1F6IxBqoOS9XshX/k/CTvbia4fi6qF0edw//dgBbNnaQIwbfDwuLzLJN/bV?=
 =?us-ascii?Q?LgPpts6YQjNBB01De7/Sfauv8H79JcOpg00i+8ZZUAWwaUKrRP3gi2udCRKV?=
 =?us-ascii?Q?ySCcT7DybEXll7xscx2K0DqEQsIMboawKb0gPlg43QrQy36ZK/NX9vZjC4VU?=
 =?us-ascii?Q?9TxQmDeECA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d776e67f-90ff-4163-d5ca-08def6f25685
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:16:22.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFyUV2A/Rba/mQhLB0Fa9wxq5gcc/TXfvrNy5J1FfI9L5Ukw2XAlS5qBCCp0hzhcpUEx3QQOU4qET3H5Mw34VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Proxy execution retains mutex-blocked donors on the runqueue so their
scheduling context can execute a lock owner. sched_ext cannot safely retain
such donors unless the BPF scheduler explicitly participates in their
admission and ordering.

Make sched_ext reject retained donors by default. Implement
scx_allow_proxy_exec() to force blocked EXT tasks through the regular block
path in schedule().

Also fully deactivate any retained proxy donor in sched_change_begin()
before changing its scheduling class. This prevents sched_setscheduler(),
PI transitions and sched_ext activation from carrying an existing proxy
session into the new class.

Some RT/DL PI transitions could usefully preserve the proxy session. For
example, an RT waiter can boost a FAIR donor which is itself blocked on a
non-PI mutex; retaining the donor would allow the boosted context to keep
proxy-executing that mutex owner. Doing so safely requires defining which
scheduling classes can carry retained proxy state across a transition. Keep
the conservative reset for now and leave compatible RT/DL PI chains for
future work.

This is a preparatory change to support proxy execution with sched_ext.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c    | 9 +++++++++
 kernel/sched/ext/ext.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 08b4245a8f6b0..26d351ac27a80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11235,6 +11235,15 @@ sched_change_begin(struct task_struct *p, const struct sched_class *next_class,
 		flags |= DEQUEUE_NOCLOCK;
 	}
 
+	/*
+	 * Don't carry retained proxy state across scheduling class changes.
+	 * Compatible RT/DL PI transitions could preserve the session so that a
+	 * boosted donor continues proxy-executing its lock owner. Defining which
+	 * class transitions can safely retain that state is left for future work.
+	 */
+	if ((flags & DEQUEUE_CLASS) && next_class != p->sched_class)
+		sched_proxy_block_task(rq, p);
+
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
 		p->sched_class->switching_from(rq, p);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4f2b0f1583989..5efbd80304dae 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -26,7 +26,7 @@ DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
 bool scx_allow_proxy_exec(const struct task_struct *p)
 {
-	return true;
+	return p->sched_class != &ext_sched_class;
 }
 
 /*
-- 
2.55.0

