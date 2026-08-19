Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F42DF3F2
	for <sched-ext@lists.linux.dev>; Wed, 19 Aug 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109181; cv=none; b=DS1xH2Y3UG/+7UiXokqpPyDdsvG5cqWL4F8XrQWTshRJSZPT339VB7p/E75nE8HAu0GJ2FhLETzwBHnv3B52zT72hH+wLuUKifpbOZLSBQStG0vqRdzXW4NDeJnrGQCWMSKGyI103cmEMygUdtC7Nz7YDHpwl1zlZYkX+v1vrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109181; c=relaxed/simple;
	bh=Ha4NBEMBfbDovOyN+LmmgFOARABrz85F4XzqKFqNzVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vhi/ToitjsCwZLh3YRmtGuV4vLlCWWG2XgXIP3ljmGq8SBDmnnXcAjeNHVn/pFWhkmUskUQmEBLk9inzZF3izD4ETgkMD6LG5txOa2Q1l72eGDZ1u/xn3oljZiweHhoOWPmFCQYqek9fICSOp9tTwA0CqPEWLFjQ2ZZAUZ4gyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ded479329b7b11f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ba1682ab-9e29-455a-a890-c48c59a0706a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:4a12cd713266b0b56f53527ca81627fb,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ded479329b7b11f19a56ed5b684f684d-20260819
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 189414787; Wed, 19 Aug 2026 11:12:54 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH 2/2] sched_ext: Fix nonexistent field in sched-ext.rst example
Date: Wed, 19 Aug 2026 11:12:44 +0800
Message-Id: <20260819031244.178638-3-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819031244.178638-1-luoliang@kylinos.cn>
References: <20260819031244.178638-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The ops.exit() example in sched-ext.rst reads ei->type, but
struct scx_exit_info has never had a type field - the exit reason is
exposed as ei->kind since the struct was introduced. A scheduler
written following the example fails to compile with

    error: no member named 'type' in 'struct scx_exit_info'

Use ei->kind.

Fixes: fa48e8d2c7b5 ("sched_ext: Documentation: scheduler: Document extensible scheduler class")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 Documentation/scheduler/sched-ext.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 2771ea4cc14a..96ff66c91ceb 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -229,7 +229,7 @@ optional. The following modified excerpt is from
 
     void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
     {
-            exit_type = ei->type;
+            exit_type = ei->kind;
     }
 
     SEC(".struct_ops")
-- 
2.43.0

