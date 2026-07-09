Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FA406299
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591435; cv=none; b=KjOIwai5rhjS7ovkN8OLaOk0D2OfiFCFfDtk+nbBqoQK1G6Ba2r94COVPXQ+N2etmz1LKCMIgl/O7dxAU57JaT7RqE1SEiuiAGi8SgAU3Ha22G8O4FSiuZsF+YhOVL/5+fSFUXw4TdQNItPyAETE6NxjDEuKtz2ld64sJAnUPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591435; c=relaxed/simple;
	bh=SPSqxrxCg9nNyXrn+amFHxw6m8DxxJhuS+jpQ/rJGpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AP7xDOjz4nU/2Pod8PSWWgLP/Zd2HMHDgUDy63ECN1JWWfifs6bVJLdLOmpyGb7CUNswCz51qpH9S10nD53WQt3SpNERUXEF+mOSm54f0CdM4dKMbpCFulifLHfzH51mP8XrAWXwKW1ZlLKWoa5Vy4VXF0B0aP9RGxh887lGLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 78e426547b7d11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:28960dec-cc1a-4cbe-ac97-421d9e426cc8,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:b03dd38be0da544b870e93eaf6194f83,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 78e426547b7d11f1aa26b74ffac11d73-20260709
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1470025836; Thu, 09 Jul 2026 18:03:45 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] selftests/sched_ext: Fix bpf_link leak on early return in prog_run
Date: Thu,  9 Jul 2026 18:03:40 +0800
Message-Id: <20260709100340.706670-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

In prog_run's run(), the bpf_link is attached early but only destroyed
on the success path. The three SCX_EQ assertions between attach and
destroy expand to a direct 'return SCX_TEST_FAIL', so if any of them
triggers, bpf_link__destroy() is never reached and the BPF scheduler
stays loaded. All subsequent tests then fail to attach because SCX is
not in the DISABLED state.

Convert those assertions to explicit checks that jump to a unified
'out' label which always runs the cleanup, matching the pattern used
in cyclic_kick_wait.c.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/testing/selftests/sched_ext/prog_run.c | 34 +++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/prog_run.c b/tools/testing/selftests/sched_ext/prog_run.c
index 05974820ca69..1129ec2aaddc 100644
--- a/tools/testing/selftests/sched_ext/prog_run.c
+++ b/tools/testing/selftests/sched_ext/prog_run.c
@@ -28,7 +28,8 @@ static enum scx_test_status setup(void **ctx)
 static enum scx_test_status run(void *ctx)
 {
 	struct prog_run *skel = ctx;
-	struct bpf_link *link;
+	struct bpf_link *link = NULL;
+	enum scx_test_status status = SCX_TEST_PASS;
 	int prog_fd, err = 0;
 
 	prog_fd = bpf_program__fd(skel->progs.prog_run_syscall);
@@ -42,23 +43,40 @@ static enum scx_test_status run(void *ctx)
 	link = bpf_map__attach_struct_ops(skel->maps.prog_run_ops);
 	if (!link) {
 		SCX_ERR("Failed to attach scheduler");
-		close(prog_fd);
-		return SCX_TEST_FAIL;
+		status = SCX_TEST_FAIL;
+		goto out;
 	}
 
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
-	SCX_EQ(err, 0);
+	if (err) {
+		SCX_ERR("BPF_PROG_RUN failed (%d)", err);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
 
 	/* Assumes uei.kind is written last */
 	while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
 		sched_yield();
 
-	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
-	SCX_EQ(skel->data->uei.exit_code, 0xdeadbeef);
+	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_UNREG_BPF)) {
+		SCX_ERR("Unexpected exit kind: %llu",
+			(unsigned long long)skel->data->uei.kind);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+	if (skel->data->uei.exit_code != 0xdeadbeef) {
+		SCX_ERR("Unexpected exit code: %lld",
+			(long long)skel->data->uei.exit_code);
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
+
+out:
 	close(prog_fd);
-	bpf_link__destroy(link);
+	if (link)
+		bpf_link__destroy(link);
 
-	return SCX_TEST_PASS;
+	return status;
 }
 
 static void cleanup(void *ctx)
-- 
2.43.0

