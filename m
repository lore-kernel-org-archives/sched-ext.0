Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCF35E1A3;
	Fri, 24 Jul 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920615; cv=none; b=S+3ChL4IdNZAg1FgnxyPERDJw7YOF2bjuHjoYL+u+a+bQY4HRk1vmb3yehaGaccsYpNleqCIO+JOzuvEuMtzYQ3ziaessBWa1PJORtxbl7mDMBOfjRAbPA4pAXNUrsnbidPKwjYoOmJmTBWU9nI7fGi8Djx9TuG5fFnk2/6FrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920615; c=relaxed/simple;
	bh=PlIIEcHZ+ukIV45aALx4KSwTVpqHGgqmz9hHbR0V/hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzGVpTcEuwL+QjxnOsPDP4X/Ql1wFNoeNkhOAFIit0KaJUGVM4d6FYTRu4WgB8RSIfPBkithEiAC10axQya27J4SQKJJDbaCiQbcyUTIGQw0VQHwnFBqzvJ/2rNzIKAdyVivFZlNXqfp1Umo4AaUGZmtOBRZ2Vd5DSTli8IjdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjN2R7cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjN2R7cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9201A1F00A3A;
	Fri, 24 Jul 2026 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920613;
	bh=KKlJ5w5YxvmHzIaeVfRK8g+Hv9W4Bgg1ftAt88bbOGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjN2R7cE91kbAa1YAObafiy2iQe8Ap8saJSamT7r8hpkHNR5fn7I/J7r5Vt8KdDHG
	 sqGoQ347kqrlKoqes/aseAjyauPrVVvJlxuMoyQNuRkXWWNmDZbcVVzVK9HuQwW8XY
	 aG2M0YL6lqOkF9Po5tX7cPgqSFATah7iS/usNMrJUvB2dgniph3bkHAsWA+MQ8K+K3
	 luDDSi5wDChPz4c17m77QOCV1CSEsAJaHw37XWg8n46ymJ7DxTOUuyhLaaHmJYcjCJ
	 vi7dpcCvmjAYemEqNnTQGrFVajTQvmhvGFmBhwbcbR0fdgUpKXhautYYttWvMuD7ye
	 osoG0HzUx/WAA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] tools/sched_ext: Don't restart over a pending exit request
Date: Fri, 24 Jul 2026 09:16:47 -1000
Message-ID: <20260724191651.1040227-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724191651.1040227-1-tj@kernel.org>
References: <20260724191651.1040227-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tools restart when the kernel exits the scheduler with
SCX_ECODE_ACT_RESTART. The restart decision doesn't consult exit_req, so an
exit request arriving while the restart condition persists is ignored and
the tool reloads in a tight loop. Test exit_req before restarting.

scx_userland needs more: its main loop never watches the kernel-side exit
and exit_req doubles as the stats printer's stop signal, set by the teardown
and reset on each restart. Add the missing UEI_EXITED() test and give the
printer its own stop flag so that exit_req only means an exit request and
stays latched like in the other tools.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_central.c  |  2 +-
 tools/sched_ext/scx_cpu0.c     |  2 +-
 tools/sched_ext/scx_flatcg.c   |  2 +-
 tools/sched_ext/scx_pair.c     |  2 +-
 tools/sched_ext/scx_qmap.c     |  2 +-
 tools/sched_ext/scx_sdt.c      |  2 +-
 tools/sched_ext/scx_simple.c   |  2 +-
 tools/sched_ext/scx_userland.c | 11 ++++++-----
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 4a72df39500d..e1acaed4ec31 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_central__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_cpu0.c b/tools/sched_ext/scx_cpu0.c
index 84a47aee2f95..1c2b507b8b34 100644
--- a/tools/sched_ext/scx_cpu0.c
+++ b/tools/sched_ext/scx_cpu0.c
@@ -99,7 +99,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_cpu0__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 7799782b76d1..a223bff3746a 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -233,7 +233,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_flatcg__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
index 41b136d43a55..00f595b58f97 100644
--- a/tools/sched_ext/scx_pair.c
+++ b/tools/sched_ext/scx_pair.c
@@ -190,7 +190,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_pair__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 27ffda1c519e..3f54796e48be 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -465,7 +465,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_qmap__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_sdt.c b/tools/sched_ext/scx_sdt.c
index ef197b266a36..2f93a00de548 100644
--- a/tools/sched_ext/scx_sdt.c
+++ b/tools/sched_ext/scx_sdt.c
@@ -96,7 +96,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_sdt__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 34f9785335b7..b7589a83f28a 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -104,7 +104,7 @@ int main(int argc, char **argv)
 	ecode = UEI_REPORT(skel, uei);
 	scx_simple__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
index 192b79c7e4aa..b16b6db5f365 100644
--- a/tools/sched_ext/scx_userland.c
+++ b/tools/sched_ext/scx_userland.c
@@ -52,6 +52,7 @@ static __u32 batch_size = 8;
 
 static bool verbose;
 static volatile int exit_req;
+static volatile int stats_stop;
 static int enqueued_fd, dispatched_fd;
 
 static pthread_t stats_printer;
@@ -286,7 +287,7 @@ static void dispatch_batch(void)
 
 static void *run_stats_printer(void *arg)
 {
-	while (!exit_req) {
+	while (!stats_stop) {
 		__u64 nr_failed_enqueues, nr_kernel_enqueues, nr_user_enqueues, total;
 
 		nr_failed_enqueues = skel->bss->nr_failed_enqueues;
@@ -374,7 +375,7 @@ static void pre_bootstrap(int argc, char **argv)
 
 static void bootstrap(char *comm)
 {
-	exit_req = 0;
+	stats_stop = 0;
 	min_vruntime = 0.0;
 	__atomic_store_n(&nr_vruntime_enqueues, 0, __ATOMIC_RELAXED);
 	__atomic_store_n(&nr_vruntime_dispatches, 0, __ATOMIC_RELAXED);
@@ -404,7 +405,7 @@ static void bootstrap(char *comm)
 
 static void sched_main_loop(void)
 {
-	while (!exit_req) {
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
 		/*
 		 * Perform the following work in the main user space scheduler
 		 * loop:
@@ -434,13 +435,13 @@ int main(int argc, char **argv)
 	bootstrap(argv[0]);
 	sched_main_loop();
 
-	exit_req = 1;
+	stats_stop = 1;
 	bpf_link__destroy(ops_link);
 	pthread_join(stats_printer, NULL);
 	ecode = UEI_REPORT(skel, uei);
 	scx_userland__destroy(skel);
 
-	if (UEI_ECODE_RESTART(ecode))
+	if (!exit_req && UEI_ECODE_RESTART(ecode))
 		goto restart;
 	return 0;
 }
-- 
2.55.0

