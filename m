Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7132C3755
	for <sched-ext@lists.linux.dev>; Sat,  9 Aug 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765331; cv=fail; b=TTk4GIfdCX4RHfm6kGKg9KKcuRj5EWMgYd5ZyzPbl8pGXAfk7SojuMhz79BNfMQyYFP7e2LTh0Vj1ihsNuBoFmTAg7H6PEu37SzeVRCo6cYkz9kwzotR4ThvvGWfe70YRg0uwqsahPiLE6nBSFkv42jSlozdaYqGFG1rHwDrHmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765331; c=relaxed/simple;
	bh=Ipftw5pjrSl80IjGQ07seXjC+iLbSLpRPV8DApcHq8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1kj0O4T5QbCf79fJMgN5SI/P7XhiX4DVY2fdsT293SyuM9cVTb1XBj8FDJO3CTn/lLEF2xGRZWlNO38jlmbdrRIwX3M4ShpPxNs0wefoHHTy8yBH3gfWo0uqRIYFizm46f5OX/7GcK5RnEvBAwkVOEZC5LPx5MlJ1KUfJPVGvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3MyxFM+; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3MyxFM+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aG3SAFLtpZMh67tKLlrPBKv1n7m6mIbWrxZjkbdg3MEP4b4Y5xgU8r8rfXLsN5YNhhvvBv1iy42P6Y5M4lTe8g4HVPzbWulSbKSv6TdYTnVJ/xjV4uEMTpyNQ37y1J5cn7GxYFLq2p1n893+lToJZNZ8aVXJ391mFZagc5+qlg9cK8JzMC2fIrHQb4KnSzNsBXTo3RQq0zEm3MU25S5uFN/Z/gav9o36+YTHYpeyiM9JF8uu6mxnE/G1JycSo+vEqLypdIPq0R6lRWaSjOsDUFATUTjc/zsKu376R+5cXUiBSKVSKgauoFcowLidyngizH38UDjMKzYeZ/g7+paDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YAFOuE3qQrqpfIZ480g2WPDhlK+bXpKgk8cqa9ZhHk=;
 b=kSVXgKKFgSddKbE+GP6Fe/BYllsdIze1XAaTaPr64hiGmqKydRNe53twxi01H44LGQJhXn39mgf9Du7X86EkN75cKkCeDpAeIRYgQHsr9lmk4f0BVm8W8YWIkbkQJ6YHrcXrdM1XTIG6LgycnrEj09iKJz6Ko9FqyxQp/TnKJLT6OD3auYYuXgqYqObRFcN2VSfpTmcAIPPJnx/cShAk7FRSLI6PQhKP4bmALWN2rWozub0axK2PPWj06wIpy5jFvrFUIxebFkV/Auticz6MQ3LVY2AK+a2p2ohRxBFXxk+RnpMNWCKm0J+8O7bB71AKQNY1fyXMh9gQMGOsgKSgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YAFOuE3qQrqpfIZ480g2WPDhlK+bXpKgk8cqa9ZhHk=;
 b=c3MyxFM+4XRk/gXztFjikWCfCzgtZ9RMGeenu+NccW/7jnDs4qJ1itlP0jOnZ5sY1f3tgArv5sjKW3Ze6pyUX6PbPdRRKTo0yfKlwjvrsWSLmGbbB0jRiTlbtEZU3piMYUVtIujWhcZr/RZuLJnczToYDL7JenH1js4o6GcMMWX1rleeamXyAGdh0n2uLbUrUuly3vfV4qAsNCnhGuFMAeDdFbWKg8Su3IdixqeZl/tRppbZiuJrCGAddh/bzmAZrZg5YDZOYYozdfddJ2/8jx8Ra1Y/jZom3Om0q0y9TtyDnNXg/RUZ+X5C/dwmUccUPTZ44Vok0m8V7edVTgVx9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:46 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:46 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH -rebased 12/15] sched_ext: Selectively enable ext and fair DL servers
Date: Sat,  9 Aug 2025 14:47:57 -0400
Message-Id: <20250809184800.129831-13-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:208:32a::16) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: eda7ab6a-2864-4b1c-1a10-08ddd7755f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mly1BEJQAzs/TZCrMBj4O2lDMepgEdkjmBAlLD3NqC8X7QbBy17oogL0prau?=
 =?us-ascii?Q?xeHnwmq2V9vmRQNOC+rCKAtdkk+Oczqnxy8OtlKaQMf3p0oMf1bYhCUfoN66?=
 =?us-ascii?Q?8LS8ybO4Ukg3xECllSjuiLrGMF9gLG2NNmVGyq4SusfdIPP9f5//xa9D9Db8?=
 =?us-ascii?Q?zfiCeSIwylp4ByxcWFU1Hq7Yys6Q5hl5LTrZU6MBDNt6SeNzAUUVJOmsS3Gl?=
 =?us-ascii?Q?XCq0c5fdBIvUY/oyqk+GIU9LXmBdw9eHOjak1s7GvwuP6ERyL2mBLFKD+imS?=
 =?us-ascii?Q?Xj3Ok2Oa2RusbiPw+Eyu/7oLCjgAngZsuxjl9Uz/ye/cccvWb4OKrJ22c4Nn?=
 =?us-ascii?Q?21RzUj2z/bmrMxk3w9lRQNnXb8k7vS/MF+aUuM4JNoHaP0Ay4CJPQ9kXjtxn?=
 =?us-ascii?Q?FsuGyjz1vFBHwjxG1DaHRyKBtiq03cguIyH8gE+Jz2OL7zteqR8zRPQ0UCY5?=
 =?us-ascii?Q?SMcBphXv/qvVR+qlGNi3EWN10QGVyO91Kop59MXjaPbpQr6cp758IdwrDfzD?=
 =?us-ascii?Q?T7ZjTpi8hluymDLSaxIbTEUdKTVQgZwU2vQcaspHij+K9ajZATRm1zm8bu/E?=
 =?us-ascii?Q?hwP7V+M8NisKz11/K88TxprBY3AFhlY8r3vNJgu1r+06wqRZ8KNbD3y3yXFG?=
 =?us-ascii?Q?oVAOHdVVfIpH+ekWclUCITSURq5UVYfM6eQbwlJcjiYNUyWrLkJTKLeLImUr?=
 =?us-ascii?Q?FURaBZc21KzQdYOHhqEDhuh7OJLuZDUZA5eyxKzL+aOd+cxd0hUNtn8j/399?=
 =?us-ascii?Q?jwLDeIjy8uF3oUWThJH07P6dsWjcTX2STCOSKiZE/grfdiBjKawrPKdp6GKz?=
 =?us-ascii?Q?xn3Mazsiu35BNOOI03vsHTLLJEbu+9XdWT20W3jvbPfFYb/Y0Oy2EkpoIwkA?=
 =?us-ascii?Q?Skz72U7yWMxZJS93qiS9ANRcCu9BdUlDE5rvUZPpdeSAB1h9URiSaMi42PIz?=
 =?us-ascii?Q?schFGvaTUfuMm4MdGrKe1UOI9g1pGZviIsrMOeiCyP5Rpe70uH1qOYWRSyMz?=
 =?us-ascii?Q?cK4hysJr6uyy6Xg1SYFqhCNFheUTg6+j3XrPzETWHAKnKAnsYeYlT3q+lNMM?=
 =?us-ascii?Q?Bhw812KbvJK1Z4d80tXiIDtlu8MZ+7T8h8FkE0T6ZrT2otDXYUjLnXB86cPX?=
 =?us-ascii?Q?v38gdbFAEXCWYSZuvKvP21JfP7ClZZ/QZBVxti+40TPbmu2RJ7HxPPgCfwIL?=
 =?us-ascii?Q?udUrRdp3swi6FXcY/sI7pRcng19u8w4QyCwexWXqEC0bAzSWsAFJqLkv3unu?=
 =?us-ascii?Q?R2jbdlxADawMVLDWlKF7gKN7we8HpIgby4PLieF5l2onDF8Xc1UNLnPXTCqs?=
 =?us-ascii?Q?rJasoijJV12/PUWsoMVjoWI2sIJ971Yy2moB4+WC6zKzjvxTgeV9E19nbrDo?=
 =?us-ascii?Q?yNC8L9uCvEwswceFV9+3torvHU3nfsIiD8NTY60NCqocR9F1Ho4TDFKgtaJP?=
 =?us-ascii?Q?g718rPd9zIAbxRBwdsmJmKpdmWkrohY0LZIrE/i6hp3HwcKyEs7YTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjGmR112gBPlAKQROqZqyXhPTBcA/qHu4K+E4yoToAEXWOledZUY84u7sTeP?=
 =?us-ascii?Q?0hdujbLJMC8Lb9F3MC5OQLW5b5qi8R6w/u2+mYuVgXHtkSNTXpvQA0O75Anf?=
 =?us-ascii?Q?dNNZECMWq+v1Xrc138KgRbs5/TIykTDnryRty97L02NOGkoC4MIitKoCW5FP?=
 =?us-ascii?Q?B62Ux00ygW+8p4/Gg22pdzOpmUbInuOBx3abau00IwGg/h02auNBUnUXm1SS?=
 =?us-ascii?Q?TSBNZxMYG1uo005w2aqWfISa99dvnTZu2lEz/O5QywAQrH6mQ4fvuVOeidiL?=
 =?us-ascii?Q?L0Efiw6zQbSvo5Qhrpu3Of6w6MBq649Hvd1BPD2WbyX7OQzAbawfnOtJPwrw?=
 =?us-ascii?Q?/VJKlOa+f0Wnm2m6gVYrmuC1618bj6fF+WcvkrJqDhOb0iHsaLUPXRh1DqY1?=
 =?us-ascii?Q?3T3R4wg/JcIwPXsMFcPYu3j3Gg79xohvJbdDEDAGm+Y83XuyjmDTBgA8NSzo?=
 =?us-ascii?Q?Jq8fhD5r10ca+4HSL4fTr8kftzk6D5SyrD2YmOKehLMdR5sgSEhtiFHgoG0u?=
 =?us-ascii?Q?mo7tCdiD5dk+SRLBl13Pw6REFegkSUqAMvorvkhd4ra5Mcg9nDipfES3/zCw?=
 =?us-ascii?Q?D3JpLiYjJhpa1PIng+pXGLbMTH2a471i/5tbHcAN6te9JkJ4m80OkFh8y9XF?=
 =?us-ascii?Q?++TB+c/PF6b8RmEpgx1jvU207JxcSprBt/ys2T3V4oh2Tbd/X8vM2puQxwwI?=
 =?us-ascii?Q?Nf8gIlT+wWWYuJ0KT/E6haO1BpxErfW/cHBioQm24I+634mcJ/k+ndfIKjsQ?=
 =?us-ascii?Q?C7V2OFNlUeUg+n58y3ijfdqzJ7nUIn5hk8m5kbYaMGmVosC3Dn+3Gy4j5qU9?=
 =?us-ascii?Q?ajMCDtpOAC72d8AWgA10oCVcHuiJG8M1NwcHTnUGSzghzcbLp7RZ8WS3kL21?=
 =?us-ascii?Q?zFQS8up2xcfVZwvbI9WtAUlQ6MDzefh5MoNeMsKHum77nLXZXCyY/vRtcRpe?=
 =?us-ascii?Q?WXA2sNAlUS1GlhWDGQzunnotl04xFcNOtfLYxCB/Fjh9pP7eaTuWjljmyiur?=
 =?us-ascii?Q?WFE19nSlLrHSJYMmCnVWXjDNxezkwDd0Sq2lW7b1mQAwqBkJ43Z8eFeLWEvK?=
 =?us-ascii?Q?b4bGV/EnU45RooWoXIRmbTMV4heiPtenzHfDDFIeQLu8jeJOPpu7ep8gLgEp?=
 =?us-ascii?Q?HB0UyxFGJjOD7VFxo3LpyRy3ZtOAsZ1kJaayrZpIRyFp7vq6Sr66OUN0D1ca?=
 =?us-ascii?Q?ZvBVgdJLU61MSBBfdf1iKeyfLRQeVXqsSeHLCQpEbjp7KFwzypkGS0LDdG3t?=
 =?us-ascii?Q?Ve+ww28Ll9ZUCW6voeNrTr3zD2m3YTk/QHeJ+1z8xYHme6X3x5qcbItk2GYQ?=
 =?us-ascii?Q?yAP76mXT7/adcitrg0Qung22mfCsEcVzAk8SoZbpVK13mCIFj+aiMrLgCJc9?=
 =?us-ascii?Q?x6Vw8gZ0BOpg1lgFdf/B5c/lrkbfXpalWE0wNJyNEgxqWv+P2kSJL5F+9TJr?=
 =?us-ascii?Q?vxvcmx19JvlWb9dqRc6xWcZf4skjn2AW62uNy3rgmtgxZasCuOl42/V8Jdld?=
 =?us-ascii?Q?Sapap7PlcPlhPD/kPMyRBzUdpbX8L2lTjfGLAiyMSxc4XVpRsgQmmBHRY0Ia?=
 =?us-ascii?Q?eFUc+PJaquEYfDpExYxQBW7DZ3B5WKnZs5mzy1E0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda7ab6a-2864-4b1c-1a10-08ddd7755f2d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:46.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azWmgWqu+WLX4m+5Iu8IDiZZhlv5jTVT5y3WHrqe9GRzkSMSS2fBH/uzuXeZi8gw4VvGfxoeCpvre2IyCuvGTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Enable or disable the appropriate DL servers (ext and fair) depending on
whether an scx scheduler is started in full or partial mode:

 - in full mode, disable the fair DL server and enable the ext DL server
   on all online CPUs,
 - in partial mode (%SCX_OPS_SWITCH_PARTIAL), keep both fair and ext DL
   servers active to support tasks in both scheduling classes.

Additionally, handle CPU hotplug events by selectively enabling or
disabling the relevant DL servers on the CPU that is going
offline/online. This ensures correct bandwidth reseration also when CPUs
are brought online or offline.

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 97 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1f68f9e69d03..2e01a4ad34ff 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3603,6 +3603,57 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 p, (struct cpumask *)p->cpus_ptr);
 }
 
+static void dl_server_on(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (switch_all) {
+		/*
+		 * If all fair tasks are moved to the scx scheduler, we
+		 * don't need the fair DL servers anymore, so remove it.
+		 *
+		 * When the current scx scheduler is unloaded, the fair DL
+		 * server will be re-initialized.
+		 */
+		if (dl_server_active(&rq->fair_server))
+			dl_server_stop(&rq->fair_server);
+		dl_server_remove_params(&rq->fair_server);
+	}
+
+	err = dl_server_init_params(&rq->ext_server);
+	WARN_ON_ONCE(err);
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void dl_server_off(struct rq *rq, bool switch_all)
+{
+	struct rq_flags rf;
+	int err;
+
+	rq_lock_irqsave(rq, &rf);
+	update_rq_clock(rq);
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_stop(&rq->ext_server);
+	dl_server_remove_params(&rq->ext_server);
+
+	if (switch_all) {
+		/*
+		 * Re-initialize the fair DL server if it was previously disabled
+		 * because all fair tasks had been moved to the ext class.
+		 */
+		err = dl_server_init_params(&rq->fair_server);
+		WARN_ON_ONCE(err);
+	}
+
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	struct scx_sched *sch = scx_root;
@@ -3618,9 +3669,20 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (unlikely(!sch))
 		return;
 
-	if (scx_enabled())
+	if (scx_enabled()) {
+		bool is_switching_all = READ_ONCE(scx_switching_all);
+
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+		/*
+		 * Update ext and fair DL servers on hotplug events.
+		 */
+		if (online)
+			dl_server_on(rq, is_switching_all);
+		else
+			dl_server_off(rq, is_switching_all);
+	}
+
 	if (online && SCX_HAS_OP(sch, cpu_online))
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cpu_online, NULL, cpu);
 	else if (!online && SCX_HAS_OP(sch, cpu_offline))
@@ -4969,6 +5031,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
+	bool is_switching_all = READ_ONCE(scx_switching_all);
 	int kind, cpu;
 
 	kind = atomic_read(&sch->exit_kind);
@@ -5024,6 +5087,22 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
+	for_each_online_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		/*
+		 * Invalidate all the rq clocks to prevent getting outdated
+		 * rq clocks from a previous scx scheduler.
+		 */
+		scx_rq_clock_invalidate(rq);
+
+		/*
+		 * We are unloading the sched_ext scheduler, we do not need its
+		 * DL server bandwidth anymore, remove it for all CPUs.
+		 */
+		dl_server_off(rq, is_switching_all);
+	}
+
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
@@ -5047,15 +5126,6 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct rq *rq = cpu_rq(cpu);
-		scx_rq_clock_invalidate(rq);
-	}
-
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_enabled);
 	bitmap_zero(sch->has_op, SCX_OPI_END);
@@ -5800,6 +5870,13 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
+
+	/*
+	 * Enable the ext DL server on all online CPUs.
+	 */
+	for_each_online_cpu(cpu)
+		dl_server_on(cpu_rq(cpu), !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	scx_bypass(false);
-- 
2.34.1

