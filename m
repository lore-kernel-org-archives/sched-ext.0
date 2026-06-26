Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D993EA94C
	for <sched-ext@lists.linux.dev>; Fri, 26 Jun 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467979; cv=none; b=QMAcwq5FgOBb2YPX1QE+f4zldnSKSXhtLVfhtpIykjKhubjB6njxyDG5KMj30YP9CpZg4Uw9Q6dHXHtGVJfMR7KovkhZlmEh5bzlMaC4xMZFhJEQc3wDEKwToZ8g8950RhKzY5VlGOAYzZ+XRqroLNhwcwdMQDe7xFkrBN1LVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467979; c=relaxed/simple;
	bh=pxsg5xhN4Qq651qUozKudIxH4Gez0OXghOF3SpYOx8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uH/UtXI8jEjWPHzj73DekwAIazEhW2WrnFlMIs3ylHcPi4YF5B0fuOwheQ8slbCcZtcUP8jrJK+Qc1IlTzgneGfjepRP+kSYQZvIoCJ88k0K/s5cOXS8Rg/dGPr6d9qgiWAcwl+utceRW6Lq6A2Hhv0c/TvnR7jMHYU4tm44rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ba9b0190714511f1aa26b74ffac11d73-20260626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d08f7d23-631b-4719-abdd-3c9d9d83baf7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:14525d59427cd33e137d8cfb09cc3738,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba9b0190714511f1aa26b74ffac11d73-20260626
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 505056140; Fri, 26 Jun 2026 17:59:32 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: fix getopt() option variable signedness
Date: Fri, 26 Jun 2026 17:59:28 +0800
Message-Id: <20260626095928.2912889-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Four example schedulers (scx_simple, scx_cpu0, scx_sdt, scx_userland)
declare the variable that holds getopt()'s return value as __u32.
getopt() returns int and uses -1 to mark end-of-options; storing that
sentinel in an unsigned variable turns it into 0xffffffff, and the
subsequent 'opt != -1' test only happens to keep working because both
operands of != are promoted to the same 0xffffffff.

Declare the variable as __s32 instead, matching getopt()'s actual
contract and the style already used in scx_qmap.c (int opt) and
scx_pair/central/flatcg.c (__s32 opt). This also silences the
-Wsign-compare warnings emitted for the affected files.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/scx_cpu0.c     | 2 +-
 tools/sched_ext/scx_sdt.c      | 2 +-
 tools/sched_ext/scx_simple.c   | 2 +-
 tools/sched_ext/scx_userland.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_cpu0.c b/tools/sched_ext/scx_cpu0.c
index a6fba9978b9c..af863b7d434a 100644
--- a/tools/sched_ext/scx_cpu0.c
+++ b/tools/sched_ext/scx_cpu0.c
@@ -62,7 +62,7 @@ int main(int argc, char **argv)
 {
 	struct scx_cpu0 *skel;
 	struct bpf_link *link;
-	__u32 opt;
+	__s32 opt;
 	__u64 ecode;

 	libbpf_set_print(libbpf_print_fn);
diff --git a/tools/sched_ext/scx_sdt.c b/tools/sched_ext/scx_sdt.c
index bf664b2d3785..ef197b266a36 100644
--- a/tools/sched_ext/scx_sdt.c
+++ b/tools/sched_ext/scx_sdt.c
@@ -44,7 +44,7 @@ int main(int argc, char **argv)
 {
 	struct scx_sdt *skel;
 	struct bpf_link *link;
-	__u32 opt;
+	__s32 opt;
 	__u64 ecode;

 	libbpf_set_print(libbpf_print_fn);
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index c3b48611712b..34f9785335b7 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -64,7 +64,7 @@ int main(int argc, char **argv)
 {
 	struct scx_simple *skel;
 	struct bpf_link *link;
-	__u32 opt;
+	__s32 opt;
 	__u64 ecode;

 	libbpf_set_print(libbpf_print_fn);
diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
index 616043c165e6..192b79c7e4aa 100644
--- a/tools/sched_ext/scx_userland.c
+++ b/tools/sched_ext/scx_userland.c
@@ -326,7 +326,7 @@ static int spawn_stats_thread(void)
 static void pre_bootstrap(int argc, char **argv)
 {
 	int err;
-	__u32 opt;
+	__s32 opt;
 	struct sched_param sched_param = {
 		.sched_priority = sched_get_priority_max(SCHED_EXT),
 	};
--
2.39.5

