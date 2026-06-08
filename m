Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199A3DEACB
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937770; cv=fail; b=Kgmj/rQzGcRlmsoBsuwW1+pgbVpuu6AclZNv3IiwOf/3mdvGGAevmz74qy+O1QWEGdBSqoHdQMz+fVZxV+tYMCIb5i8j6jrmbsbH18hW64GCl24QDBxtmWepokVBcXQBTldJAGLkwswq9QPSuTLwImkRZz7U/EvC+r1Ik0Ajkew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937770; c=relaxed/simple;
	bh=EdolHX+3rcdXCREoRngqd11eRLIOk58qe0pAa8G+PWg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MjlE2p1L8mDwoRZ3tcEUpH23zXJQ3e+q+S08FfoqHiFmlKO4V4yBYh6nTNqUt4/8Va/wJwGF6PWFhetpUN608yzmI4wkEsaH8RyzUGe1CS2/JrjjnnFb/1B7Z9wFK6Q/Jm4Jo1NibOxHT9vGNlgjJoS3k91SQcZEkrFnz03XQGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6UhFAXw; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6UhFAXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwU2U8vx2eK1rCGiwomzUj43+Ma4C+JGGEBP5Bs9EcalWAxmtc11ZzK4SVHhiRMaD2llOgnAI7x5+uXFVxyKTSvF+TwcjRez+Unq88bfyNUD8DOcuT7FGtBHmdhg6lprQeDdD0ZllZCYdc0l3n0KubEMavY4AQHlPcmhv3XStQX40xI86y2aLN2zpx8P4DekJMUs2iW/7KQcNlZ48hBflFLGoFO3mldDMpZaWumOG9PKr2PQGpF/ZU+/yQLJ0J6egCSCWSxLC6bujSzvGI1iI86Ne1QAFuTudsG7WnsJ53xf4Qt6pZ44fQGE73ZwOOcmtQ1/i1r3ewnG4t1I6IUK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2V7Njobbkoo43OolcJsYAc58B1LZjzxPNUhyltr1Zk=;
 b=s36dHJnjkaZRo6ann6gOLMwij1OrEu9H338L58TCBTvKASLub393u8hP6V/ECL1Bask1D2d8dre4N7zkZLVk4wiDvIwIveL8JqgH3/X7jJvhXbn8eqixkYSlAlHEDQHYbuhliDf4yKdGca7mZzUFA7usNjx3qlGtiFIyB6kWEedcZku3JWPGAAaMDjPuYa4BYYAATeC0lMuJoNrLnBResLJ9uzv8TWtpaAlijTd9ry/NYvoq1gELoKtkd/ne0HzOZPNJntY/TmbPHjKZqaiBzZWyNssJPfiMP0B2ViQddLKW9tQrYIsR5+krL/ZkR3ghNreQkGzPSoTCc7SLGOf63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2V7Njobbkoo43OolcJsYAc58B1LZjzxPNUhyltr1Zk=;
 b=g6UhFAXwbFEx6+nP38GLti1H1ag7bPdEnhdjD668yho0N38h+hfx3+Xumb73uYCmDAve4r+29dtRFNYUBOkIOZC6mEZFHYomnqqrh7sdfpvMhGZ2I8bFzhjjD1ZjcMUIrrwgl542OdjX/iXAGPDtmx6ITt0LzTsLqRrNs8Tl1+wYjucZzMMGyTxZiHyWu6AJ8CVDoz9i3xSq3RlvgiTOe+kwOmwPYkWsnbiCJo50X4hzepLZxMoPDK6GjV2Y1ZxjmsN0f2iyeOc0/jDtUrxzTecsdl/n5ddm8D4mJqbGT7kBYXa6DsX0WLUb0uIAXY2haqppd9YNfPaqArxnrF+isQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 16:56:05 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:56:05 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Reset dsq_vtime and slice when a task leaves SCX
Date: Mon,  8 Jun 2026 18:55:57 +0200
Message-ID: <20260608165557.3268661-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c6c8c8-0237-4418-86c8-08dec57ed42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dt8ziu8hZra4tOIhvoptb9Mk+va8Clx8nBpauLPTITqzjm4z3Z9wPdHQzHdHRbS1u3MvsYa6zYyqglgAnjcs966AjeagTjm+5ZX1Nq4iYWV8u0ZJHytz40b0Cdm6sV5K1SRxicMN4ez6T2N59iWf2peBkKkCLBJ8hK3qQBykXwHRsANTIc10B2AEdfrcZJs1+nPfG1e5z3DXkQoGXIhvLnT5jBWRvOyQrSSkuzS00O+69yQt/xo8jKFgULfcreyrDEPs3XKZ3tCTJnthE/2E91BR+KNnmQ3BEq5PHkEvf9+vx35rNkdrM8llpTPGn8SYopHtoHZuyP4vI6lYC9lU6V1Mpp8QuI3GycLhgXjnj6uHufiUPTAU+NgJqnFFTiyW4l8Yu4lLGIkSQ8MqvpU+fsqqDqL/kOyEs/aH3Ql+re5v/Bs56Go/UUCAoxyWvTBrs9ErhkNntDjoZmgqmcZGnp+GuaDWwkznubaI296qoj01bXlKLPzGaaxgkRCyjuVQMXjKjR2PDi2oHnqsFKgDTAPzIWYLM1UdCcLM0J2jBmGcyRE6Gonzaw/l8byM+DPFCyqrfCxTsZ0jthfiuus96K5gqqwlw4xDwLJqpvayA0cjLxqnJGeEudY3aaUQH8ADuGVS2Q4p9WnOinIJa/RyMI0OjMIKzgwmpwGVHZoWhr/Cip5D904iDXkeLtNTWZC/yjzvxGYie/sIR9II/BcgXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzeKvMd2kRGWqHWu0w7AYXCSoZMpZ8sqUrWwablW8XP8HyLzDbVYGVfKEjVo?=
 =?us-ascii?Q?Hevva0BWjydLQULG7iupek2d4WKdGeSyA0p+v6QFSHdLqoervd29aciwvGOe?=
 =?us-ascii?Q?mkpr+viKS4HYGlvD/AbD1zw+nz9X31Np5tzxl5yhoWQmEKe8j60u29NLgEH6?=
 =?us-ascii?Q?xqnm0BGGi5SwwxRVNUucBDM2LilG4YoOWjq4z1zAW/miDlIxG2k4t7opYfAJ?=
 =?us-ascii?Q?exc5tFyqpZEhjf0hhjieUh8HbSv13onkk/fMYT5jlOjUCAPkLIIFb8hXmjzU?=
 =?us-ascii?Q?f7iQEKXsiMnfSMU9KPf58CsbuN/ttFMmhTFw/ZSAZfksygCgnloXvlhfOHft?=
 =?us-ascii?Q?fa5ZOSj+ojluhvQwNy2/T8cx5F+WsYrjcRMKZ3M2rv/JR6SS1m8N58keAnr4?=
 =?us-ascii?Q?wJMaGhXdZHQ78mtRomakzIF0KFwSU7Y0g9epiQ57K7FypBBJkaS+8qFEOIIo?=
 =?us-ascii?Q?o/Rc5cLljivYejvg5Q51rcQXuZNfona3gm6b/6JTfAUk5EXL1c3IyTs0QRyR?=
 =?us-ascii?Q?aC7WUZQsY+sae37EeT0snuKotDmB32EYBrfGQRPlyTybjAz9BiONQmGhVhOr?=
 =?us-ascii?Q?ttYIn1HcBDrYDJ4tceIcMGj/06oaRaFQB/LcGUmcyIkZoe79xwQkBR3GF8UZ?=
 =?us-ascii?Q?OH+Bvq1+7SN7DfvlVTMGZZaLOiSs/SNspbftDpjhK3KbtqkcknMbfwQwUKzp?=
 =?us-ascii?Q?FEK5yJzzntZZPkOfynaR0bN4V5bQiVQVDIy0FKq/8xL5faZj70Vykfwuw+LT?=
 =?us-ascii?Q?tIwC4jyuf7wmFdllu6OGZyU2/stb0yyDWqJDVNSCBM5hzKpoRriRjmSRD6T8?=
 =?us-ascii?Q?3vQoqE0BVbb9Tua5AJ5/nuiwhbrxC8SwQP8cKRELFvrbeChxdPuCTxCTzA+t?=
 =?us-ascii?Q?2BArOtVh7Sop1lb6Ar9wkDA/591JvddMBFbYC0T/ErDGbeLAMsk9x6ejlugv?=
 =?us-ascii?Q?C4FvgCgJYdimHudsh2FnQ/W6L+3vxpXQUHtUmELlCm/DepXUGLZv62TcSI8s?=
 =?us-ascii?Q?rUcfxk/kFtLrQL1ohGu9mHmne8eLxrFke1o7pYDbgW+3sghFA2KXvKdeeJ1T?=
 =?us-ascii?Q?HxJietifB8zsUdWxZDy9/dsqXLeCDTNGuvm8umthBt5ALdDQCIzypGpWtu6A?=
 =?us-ascii?Q?QbexaKD9mrxsryd6G+qquWpm8+1VNOI6lwL8H4tlDoJPBkFnBpuIaecWS9pS?=
 =?us-ascii?Q?Xkpr/WB76aO6R/K2mcu7xsL5lE7Fp1VNfai8fhF0MCO1Hj+scRQjlSxSvnO0?=
 =?us-ascii?Q?ZFBjUxzdUDRkiPl7YVEFVqM7cLYkP5H3Kin6TpyxlY2zPG2ZcTaD09FNlO2z?=
 =?us-ascii?Q?bgJTUG0tPfRIJHAEv1gh6uLf7uuaNz2Arx60g8rzCf4mYSF/SFTNiN0MZ6hX?=
 =?us-ascii?Q?qENKKWDiBkql6/u1vFKzKesNYmjPUqDkKMeEbOzSMJGFjV2X/FdOaoJCHcbS?=
 =?us-ascii?Q?VMuglA4ibXGPf0XvhoF+RCCfE3YqZD2Cf8rTj4iwum38z9xz2tWaWFW2fBml?=
 =?us-ascii?Q?V0rPlIf2sSNvD8Us1g2xg/FKoheuboAwoxmq3DxNVHRCTFRL35B1aSclzUBm?=
 =?us-ascii?Q?hydXV7IiuGYT1eTctEs/wAb5PLKQLeFHb9NTO6wZKgFVntmy+WxqIZtmrk0X?=
 =?us-ascii?Q?gE1oy+EXWHrJz4Cckp46pQJ5iZG3qG0/CLi7OV1P6dzLA4F16edrTeHP3EgU?=
 =?us-ascii?Q?PHTj+WOVCqbSEtlNzDVKywsgnG82PJqG5b5z7cfnhNQdJVR3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c6c8c8-0237-4418-86c8-08dec57ed42d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 16:56:05.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZr1Yx/TEss7jIWqSqzR33H295/JREVrC3+2EkpaVi+ETIcNfMgVZGVoy5bXlRQJ4cOvj4RCrOoi7D6etnBRXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473

When a task leaves the BPF scheduler's control, p->scx.dsq_vtime and
p->scx.slice keep whatever values they last held. The slice value is
core-managed and is refilled on the next enqueue, but dsq_vtime is owned
by the BPF scheduler and is never cleared by the core, so a task that
leaves SCX and later returns carries a stale dsq_vtime across the
round-trip.

The stale values are also visible to other SCX schedulers that inspect
the scx fields of non-SCX tasks.

Fix this by resetting both dsq_vtime and slice in scx_disable_task(),
after ops.disable(), so the BPF scheduler can still observe the task's
final values and non-SCX tasks do not retain stale SCX state.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Reset SCX values in scx_disable_task() (Sashiko)
 - Link to v1: https://lore.kernel.org/all/20260608134908.3232097-1-arighi@nvidia.com/

 kernel/sched/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e88a25bc602f..01b4f29de073c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3659,6 +3659,13 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 		SCX_CALL_OP_TASK(sch, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 
+	/*
+	 * Reset the SCX-managed fields when @p leaves the BPF scheduler's
+	 * control, after ops.disable() has observed their final values.
+	 */
+	p->scx.dsq_vtime = 0;
+	p->scx.slice = 0;
+
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
 	 * transitions are consistent, the flag should always be clear
-- 
2.54.0

