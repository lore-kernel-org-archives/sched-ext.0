Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A05353EF7
	for <sched-ext@lists.linux.dev>; Sun, 16 Aug 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786901924; cv=fail; b=e4cSNvKKc49OLCX77Eu5D5sMwgOcdJWa4Xq6T2Y4DeecSoMnAO/9LiTojdL/4ORZlZ0t+A2SA3D8BbkkIUvJR+5nyeCpiNYS972QwmJWjmd04i6x7Mw+GnIiH9T86SXSkWOdnUMZBx9U1TfYUHP5SfRKb51Umgl+gTdrVuvZHC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786901924; c=relaxed/simple;
	bh=qpGg/Z320L2aDWzlN8So9159AX8vmBUjro+0tjmIs84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2u2A9mQkHXIpafzHn2QRHkqlVL3cYIiVhQ0fTI9Oio19VoJZgiwOdZfmXbfiwew7Md4V1AJR/J+RpNXahTcP3K4hRq2jbmQc/D2L9fOvDv/U5I1Acsr6Etd3MyM2qtRcBNBbDLvVgVTUUbUWiyCHMabQvr/YugWxsh1vJXOkxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwOUpQcY; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwOUpQcY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqzyNlL2X3aR5hPDnIi0G2uQBT7JCrL01TlJEqk9sEZN+cLuwqEcw7pq1yasSOput2BEI7+DePeUxCzkylU+Q1twbNYQogDTW39tlPg6lG9TL7aafVAifU9Qa3/TyUsyYIk/vFo6PSXBiZdYJMK+HuXcmMwjYSkXWMRAZ/XlPx39eBYRr8UbdlSkhasBwyMW1d3mQ6DbXjIrdXTc/+sPerHfdAJgmzs1A20TPE2fVVJlp9vbd8PkSC5OsVSZQFqNbBe5FYzHLVTplK7qqp1BMKU0uUj4+XhBiAsPUC+7kJGO6pZ+6iSMW2Mqh8/Q/WnSRs29PCPdgkb9tykjALFhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ55tvf7KT6dace1gbBsHJsXewIHPLv6doYuED/TrAQ=;
 b=PPBnnJEMI9OTodBGFNI4mso16oqsYBs2FRedafJ02lpDJMaM3XoffpFys3X4ac8N1SdeHISxxmnIXH1n7uTWKECbgAsNpgq31jJCucWkMmG7bBb9JxQTsHRPpPjvy2IBgxfyO9kHxLXuTwCxX9kTZ1zNIf0p1rKPWvsaNSoQTLdZ1tVj2YYCrCkCOnaqYQC1pke5+lMNI508hKvyXHXQt9BDtyvEWsWT9832oYBiA3yQJEbQC93JAjYm9btFI5Mwl3jzk1/MiFuiSk/KWqXIRDD6eAAf818cIxiUpWZWey9Xdu5zT96JbJEqmcN7l4bU4MUXjjYnLUbmizne90XSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ55tvf7KT6dace1gbBsHJsXewIHPLv6doYuED/TrAQ=;
 b=dwOUpQcYDIhOLf8eJuEXDuzKkKvs2e0tX3Crm8gozH3MdpHcJiTnW/VZ4jqs05p7Srgw1Xw34tmPqP/VklymIdz2Gdq8Lk9XZt3VNZqrOvHsN5kmndW+ge3gb7SzduAH4wSTp2pFc6taLCUbe1TPAabjQlKh8n0LTgEkwusgj+Q6JulLXJFKOZSXhAlO+crwldOSezpshcXhhjY6aXwbdcvVNOBq8Ggltavppoo3v6RQ/9sh2EettgugTr6XkMT/BNdcq7u64XUGP0LMoEEqPsDOJdoDSONW/C0ypi6CmJz9cAPRqsyuW3DocrFfOMzb+naY6uRN0Fwq/HwJZvAktA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 17:38:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 17:38:39 +0000
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
Subject: [PATCH 16/17] sched_ext: scx_qmap: Add proxy execution support
Date: Sun, 16 Aug 2026 19:35:14 +0200
Message-ID: <20260816173732.17162-17-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816173732.17162-1-arighi@nvidia.com>
References: <20260816173732.17162-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008CB.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::439) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: f536f1b0-f1b6-47f8-d3c3-08defbbd34eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	P8dv8PznWWdcf7t5TKPrgdFkvSyrnbYtU3g2VL6c1NBazneb8jPZhx7WFv0mx+eF6qjtDwuzaPZjYUwKne6LXNH/uG74PnHJ6Z2veLULd1ZWfhGgBEsOzImzlrgfwmuMTl1Tol7riZHaZJygBffSVKUC2/Jig1UT23Q2iowtBe4x6EZYrh2gW4DB50fGmulwVlrIu1r3YeNjbr9/N0jCYJAyz5y9UZGjnzXs7hA01X4wRjgGO5hhEVr+peeLPg+yKs6xjAaAAEdsvaaaDn/oEgX/zj4E3y6cNl4Y9v8Na6QsJV0DaONg3q31EtY9bbLPKyePnQId57g2JAqpEcEJgPbG4IKrOp43GKrCVk9h8dmy6aSway5N5pi0Hd0iAGO+w78kiliUnpYHQpC+MjsqqXAbCVSV8hgfyFFyE2e/dqZpcNPeCkAeXXmSfe9/OGo/i2Kvf/PBgRh1MIUZwerhN+G0EVFTwPraXgZI+m2ry6T6D8d5TAOW4gyeZvT+OsoTLDgtT1Yf4wK8Kl/kauIcgNPumVZtXyAHLRwZBljRTWVe85rwO6knpxyASOhHHJYLl03nw3TToPfNVIINSLPkGWoxmeEQqp7b5EFz+iJ+4BJ10nkEFn5Xznq1Ln9ILa7uJQ+u0VU5vzL264hpbMdrjneRZMFQQZnJnSkNkH9BQkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNBndD0clD7hL94zx9Jxxk9d/xH6xei6CRdSLjlKEhuKos0JD9jzKib3HRDN?=
 =?us-ascii?Q?OXKbhLVkWclRw/QJc04l3RFxw7anz8dX5QWywaFsvoTZtFJTekrUrTD4GcIt?=
 =?us-ascii?Q?p5iIiOlbFoI5DVWVs/QSt9Cq1OQs3yUOVY5hGVf4e5kH8NB4EknnckmbjfXR?=
 =?us-ascii?Q?cyLmsH2M0eDn3N+2mx7J0P07MT0ErMW3Qw2xnUYslz+iQTJvADy6T6P6mg06?=
 =?us-ascii?Q?xuyEstA3nTB1Fw5/V1UTjm51p1SE+W7/mICmMVrpGrKL/qy2LmjfVi71FvUM?=
 =?us-ascii?Q?BElQTAVZkOozH6JvlI4nTdVACFmllkk+ptiWhOEG9hYcA59rPFi+j0x4oJRt?=
 =?us-ascii?Q?3NcftKED0g2SqIfhfkfCU6+hHCE8jguYqBhEaAWAnJVRkCEiaXdVQu2qzZXt?=
 =?us-ascii?Q?Un/8Lrboi5TO+HmDSaiLrA36RjiotOZ07iLWq3raGF0CEPAxm6d3Avk4Nhff?=
 =?us-ascii?Q?qZKszj+nxNmwIkPtERZi85Ao+YZpxr2QuB2gMT4jacGLz4KIlL3E5BODdga8?=
 =?us-ascii?Q?VLEfWUGhki1hTPDl0ytgkeVFZABWTYYBw+ouVajouP3X61sWMS5rMZpABrtL?=
 =?us-ascii?Q?kEmvsOOQeDCmR+Fh1g9N2aj1nNzC+H+mQo28mDF+yfEK0m+WPaWT9iQQR0KF?=
 =?us-ascii?Q?sCxNHEt6YtCjOZuKJbIrXt77eFN48OvGvJN/zj2yWi7+NrTjGn4dVw/ObDz3?=
 =?us-ascii?Q?HfTpx4lJqDZ7jKkIYMK0k8IAwIRMD0t9koh5zaFWOvmn2yKg2u3ys+PwKYvM?=
 =?us-ascii?Q?m4CXZn3Ymk7Q4DX7ie8Xx6AI2EEvfTzu/IutfLEPGaFk1qbhyo/nBBXsnx/0?=
 =?us-ascii?Q?/pZgGhgbcnKuqO5V+IGHDJwIFTFvEUo+RvrDYPKOIuOhP1X+VdvVo67LbYKO?=
 =?us-ascii?Q?4umHRCr4n+iYUm/LtZuGXR/PcdDO+oejQnMWbEkJDY5eF8S7QCnPaEzXdvNY?=
 =?us-ascii?Q?sPUBPkeU+Rz7uWIrSNSOvfRC1igQZ24A0N4AsylvYfHhFSOPNmC4h2U8yzvi?=
 =?us-ascii?Q?qjBRRgbnCfyKtdr9BWpJdLYe4BS4O4wYQabYZxHxNJYkqbx6urwU9KIsCH21?=
 =?us-ascii?Q?soN9K6oq4atJ8yOHmhmjJuXMSBRnL3WBLxmx/ApAqvmPs5OdtTnqio3lsWHB?=
 =?us-ascii?Q?AGqPMOYbCf/TBQZSANp2TlglnXSIWkvCDUIluVEkudoSIl3zD+5fgvEPhW9x?=
 =?us-ascii?Q?iOcy4pXLnbKuWYyeGiqwkY6YSnUfWvrzRtA+fE2ncfSscCcmWOC8qwFRgdRq?=
 =?us-ascii?Q?CtDHonsHoTD0z6URUboYZ8q0o42naElzDWSAm0yp61/YwzsX0xhZd8u0v/4K?=
 =?us-ascii?Q?9AyJ9ViEp/NZmfbFekK0us8uugdGuRMqGm8CJSQyoVw5a3D8oMPLYhD834JX?=
 =?us-ascii?Q?p0MxRHAF+LAqrzseBGkDxJQUT48MqfAWcc680drMP4EPznEiYWiOWInHIQ+c?=
 =?us-ascii?Q?TWbqYH+LS7qC1zsDHiLXAJqUAcFeeg44Sd7CC0gwkTgQ2rRaa6hNkdgaG+Or?=
 =?us-ascii?Q?0dwaqJTPRusURF00QJWie/L8vPO5iXQXUuK80zH5tP7hBC6FNJxNA8+5nGAC?=
 =?us-ascii?Q?RkOPP3cewu7nN3JYvhIwQOP+IdbawkopkPuwjbhChfKBCHVPnsLcCUd6oW/t?=
 =?us-ascii?Q?5SeIB7cHteDTuuhawIziMwMWNBHYxrpM+MMmhyKfzwM3QXtS+vHFzX0tlY4c?=
 =?us-ascii?Q?zIeIUzvEYPPSOp4KQY0DUnjbpuz1JuMUEB/yQwoheSX9u5XQ7uoHemSeUJ4S?=
 =?us-ascii?Q?n1Bja4mRjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f536f1b0-f1b6-47f8-d3c3-08defbbd34eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 17:38:39.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrEJmYQN/kVkXIG3RS2iUkL+7ucqa/JbxXN/DojHguoVn0TCHL7qwDyXQc6Dr5Vaq7NgA9pTbzip+1ifvA8hhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

Add a -X option to opt scx_qmap into queueing mutex-blocked tasks for
proxy execution. Without the option, SCX_OPS_ENQ_BLOCKED remains clear
and mutex waiters block normally. With -X, blocked donors are passed to
qmap_enqueue() with SCX_ENQ_BLOCKED.

When scx_qmap receives a blocked donor, dispatch it directly to the
local DSQ of its current cid with a fresh slice and SCX_ENQ_PREEMPT.
This places the donor at the head of the DSQ and requests an immediate
reschedule, allowing the core proxy-exec path to run the mutex owner
using the donor's scheduling context as soon as the donor is selected.

The blocked policy is intentionally unfair and can strongly prioritize
tasks using contended mutexes, but scx_qmap is a demo scheduler and such
aggressive behavior makes proxy-exec support easy to observe. Count
these dispatch attempts in nr_enq_blocked and report their per-interval
delta.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 40 +++++++++++++++++++++++++++++++++-
 tools/sched_ext/scx_qmap.c     | 13 ++++++++---
 tools/sched_ext/scx_qmap.h     |  1 +
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a5f666716d803..d14242d0b5d0d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -454,7 +454,8 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 *
 	 * Force it onto its first allowed cid's local DSQ. If we hold that cid
 	 * it runs. Otherwise the insert carries SCX_ENQ_RESCUE and the kernel
-	 * diverts the task to its rescue path.
+	 * diverts the task to its rescue path. Do this before the blocked-donor
+	 * fast paths, which also require an eligible self cid to make progress.
 	 */
 	if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
 		s32 c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
@@ -468,6 +469,43 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		}
 	}
 
+	/*
+	 * SCX_OPS_ALWAYS_ENQ_IMMED makes the local insertion below implicitly
+	 * carry SCX_ENQ_IMMED. If the CPU can't run the blocked donor immediately,
+	 * the core returns it through ops.enqueue() with SCX_ENQ_REENQ. Inserting
+	 * it into the same local DSQ would repeat the IMMED handback until the
+	 * scheduler is ejected. Move reenqueued blocked donors to the shared DSQ,
+	 * which doesn't carry SCX_ENQ_IMMED, so another CPU can consume them.
+	 */
+	if ((enq_flags & (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) ==
+	    (SCX_ENQ_BLOCKED | SCX_ENQ_REENQ)) {
+		taskc->force_local = false;
+		scx_bpf_dsq_insert(p, SHARED_DSQ, 0, enq_flags);
+		cid = cmask_next_and2_set_wrap(&taskc->cpus_allowed,
+					       &qa.idle_cids.mask,
+					       &qa.self_cids.mask, 0);
+		if (cid < scx_bpf_nr_cids())
+			scx_bpf_kick_cid(cid, SCX_KICK_IDLE);
+		return;
+	}
+
+	/*
+	 * Insert a blocked mutex donor at the head of its current cid's local
+	 * DSQ with a fresh slice and %SCX_ENQ_PREEMPT, requesting an immediate
+	 * reschedule. Once selected, the core proxy-exec path can immediately
+	 * run the mutex owner using the donor's scheduling context.
+	 *
+	 * This policy is intentionally unfair and can strongly prioritize tasks
+	 * using contended mutexes; scx_qmap is a demonstration scheduler and
+	 * this behavior makes proxy-exec support easy to observe.
+	 */
+	if (enq_flags & SCX_ENQ_BLOCKED) {
+		__sync_fetch_and_add(&qa.nr_enq_blocked, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cid(p),
+				   slice_ns, enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	/*
 	 * Fault injection: deliberately dispatch one of our own tasks to a cid
 	 * we don't hold. The inserts carry SCX_ENQ_RESCUE and divert to the
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 988b6931633e9..5b74595d7d452 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -46,7 +46,7 @@ const char help_fmt[] =
 "See the top-of-file comment in .bpf.c for the design.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
+"       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I] [-X]\n"
 "       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
@@ -65,6 +65,7 @@ const char help_fmt[] =
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -X            Turn on SCX_OPS_ENQ_BLOCKED\n"
 "  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats interval, seconds (default 5)\n"
@@ -107,6 +108,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_enq_blocked;
 	u64 nr_inject_attempts;
 	u64 nr_rescue_dsp;
 };
@@ -190,14 +192,16 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu rescue=+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu blocked=+%llu inj=+%llu rescue=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
 	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_enq_blocked - prev->nr_enq_blocked),
 	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts),
 	       (unsigned long long)(qa->nr_rescue_dsp - prev->nr_rescue_dsp));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_enq_blocked = qa->nr_enq_blocked;
 	prev->nr_inject_attempts = qa->nr_inject_attempts;
 	prev->nr_rescue_dsp = qa->nr_rescue_dsp;
 
@@ -262,7 +266,7 @@ int main(int argc, char **argv)
 	skel->rodata->max_tasks = 16384;
 
 	while ((opt = getopt(argc, argv,
-			     "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:B:q:vh")) != -1) {
+			     "s:e:t:T:l:b:N:PMHc:d:D:SpIXF:C:i:R:J:B:q:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -323,6 +327,9 @@ int main(int argc, char **argv)
 		case 'I':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
 			break;
+		case 'X':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ENQ_BLOCKED;
+			break;
 		case 'F':
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c8f602d58ca3a..ee054f6775ffa 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -174,6 +174,7 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_enq_blocked;		/* SCX_ENQ_BLOCKED dispatches */
 	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
 	u64 nr_rescue_dsp;		/* SCX_ENQ_RESCUE dispatch attempts */
 	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
-- 
2.55.0

