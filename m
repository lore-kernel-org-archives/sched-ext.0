Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E35199E89
	for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379690; cv=none; b=Do9OM6YyWtOW909wueGJw3BsgsLMd/8SZDSRI3Z7HToxhkPbrv1tWm+cD2USnSDfIDvlOHfKQN1Y5QHiUMSFnE6T5VgkZWvqxLsQNhlXr2olVn6tklPWYCNbryrZ7mjgek50eeAFI0183I5FRw5mEZXKyxVb+2m//bXrulZCwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379690; c=relaxed/simple;
	bh=/WHMNXqnLU2Zm98MLAT4ZJC5oH6pjuac9UnYEsm/eTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFHARG0kTc8DdQEl6liLmZ42iql3OMLdKYbMyYq/z1C/DsnCFOIcNQ+HRE3FFcaIKYIOfT5aIpQZyg5fwDwUorkrR4iTjyM5+MoSbygkp8+gnPPULBxlQWtYSgpDMyeUF9y5b+ZvMJFtR5ma5GimsK4Lx8X4JOzFWTjYIBC+OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojc/k2IQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojc/k2IQ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0abdde280so7688515ad.1
        for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379688; x=1774984488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GavoV+GO2/EQitG0ZyZK5J9A5XlP+IlO16T2VYVdAg0=;
        b=Ojc/k2IQHigf/IgKdW6+F7OHNk6P+Ip3S41zbLFBQEoxO04ujU+nyYlC61Rmf1a1Mq
         yQaHvufbgteao4J5KRuQ8DbSIuxG5Fh+DaD56cCz+I+ZlM2Na/JxGO+UFEQ4EOKl2YWX
         gAbQFwH3q9N/3aZA9e4kfj0r3fEw8uoV2le4NTT3tV0qoI+zDfrRZjU9+stkLHF4ySrs
         cLVipmWlJ/xVbvvKUt4afVQOIaWDqufY3AjDkC8nO79R7tIUlEaGruEGW4bCCHIKSHfn
         B9DE2TIKotOpGD7QvVe7JPrtJYm2bn0e4f0AN7lwu8zutJ22FTRfjiYvWNEGiGT2oUQ+
         EEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379688; x=1774984488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GavoV+GO2/EQitG0ZyZK5J9A5XlP+IlO16T2VYVdAg0=;
        b=hEG8Pr2GRKfelBkfsdULseJ04uHr2fLfcytYz1014hroAEWCE1mm8Cq/vUOxEsNu5Y
         i9jQESjb3gkxBSnJwTo6lYD9O1ezqY7n+ssXi+viDtXzFZp3qMP9ZbGDjdminKEROC3v
         UnqjG+PHWQYMxcyRTiWgZl19C3A8vaUu8CEb+uh/3XEOxds7odgFG3AO8RDGve/sdY10
         vZr1WW2elyNz3hsQxsgoKy3rbGp+8oMg3VslI8Wlwt9vKA0KVi9wcusszV2FGrYdiXCf
         dkwr8EnzGX3B7JP06xyxoDUp1HFiUgetxUmB14ipAwp/xrEp2ey/I3jKP4+u4UfY7fVG
         7A1A==
X-Gm-Message-State: AOJu0YwCHs4JAAi7rc9s80F4UU6KpkX7EAh1COM/1UzbRR/3fSSwt5D4
	mkY8r4RXB/OH6oL8+5sExMGeYXJtyvgEuG/RjB6zKdsCstKnJtYeRopMUQcTzg==
X-Gm-Gg: ATEYQzykBBFBdKNc06hKl3aErVy/x8DO/2sL7oQvnNGj1wKsTCNs3QcDFn6VAMZuJm6
	A0l0VHUJwiqA23kt/nGN9pOXxwxkMj/o0m0BzDhlIPigRtPbxALkK0qShaMpH2KUP/kTkf+e5Rv
	mobam8fdcTJppQ9cC5gvaGCQSrEhr3pyHOmi7tR8SrdZ7Ihg2IHPzfTh31/AF1YD92lezmTF7He
	ODC9KRZV/IDHmx0cFWQC4V3WJlBCT5Wy40Ka2lKsUrwwhE8HeRznD8iYsaQ54hGPizr4CTi0MO8
	5plpzJkeaThmL1V0O/t9J3QoSacqDkM0ONQUcsQgPazRIGWPe36fyFTx3LxJHXaLHs/VNhsByxm
	6LBUZymVTofM/VIhja++M7GZovxAPMWAEChRJSZjjGitB/IoHl5uO6whABooERHidCURk8Vtd2g
	2jIX0+E/KVSllLet5kO6zi4iMCPZyi6WgYcU7P68I2zbwu9sB36bVAAstAmCHu/ls=
X-Received: by 2002:a17:903:910:b0:2ae:ced7:4650 with SMTP id d9443c01a7336-2b0b0a7f74bmr7767065ad.24.1774379688315;
        Tue, 24 Mar 2026 12:14:48 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:76ad:4f09:3dce:2442])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm151020485ad.25.2026.03.24.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:14:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] selftests/sched_ext: Skip rt_stall on older kernels and list skipped tests
Date: Wed, 25 Mar 2026 03:14:04 +0800
Message-ID: <20260324191433.1955484-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt_stall tests the ext DL server which was introduced in commit
cd959a356205 ("sched_ext: Add a DL server for sched_ext tasks").
On older kernels that lack this feature, the test calls ksft_exit_fail()
internally which terminates the entire runner process, preventing
subsequent tests from running.

Add a guard in setup() that checks for the ext_server field in struct rq
via __COMPAT_struct_has_field() and returns SCX_TEST_SKIP if not present.

Also print the names of skipped tests in the results summary, mirroring
the existing behavior for failed tests.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/rt_stall.c | 5 +++++
 tools/testing/selftests/sched_ext/runner.c   | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index 81ea9b4883e5..a5041fc2e44f 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -119,6 +119,11 @@ static enum scx_test_status setup(void **ctx)
 {
 	struct rt_stall *skel;
 
+	if (!__COMPAT_struct_has_field("rq", "ext_server")) {
+		fprintf(stderr, "SKIP: ext DL server not supported\n");
+		return SCX_TEST_SKIP;
+	}
+
 	skel = rt_stall__open();
 	SCX_FAIL_IF(!skel, "Failed to open");
 	SCX_ENUM_INIT(skel);
diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index 4c68efa1512a..d84f71eee049 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -134,6 +134,7 @@ int main(int argc, char **argv)
 {
 	const char *filter = NULL;
 	const char *failed_tests[MAX_SCX_TESTS];
+	const char *skipped_tests[MAX_SCX_TESTS];
 	unsigned testnum = 0, i;
 	unsigned passed = 0, skipped = 0, failed = 0;
 	int opt;
@@ -199,7 +200,7 @@ int main(int argc, char **argv)
 			passed++;
 			break;
 		case SCX_TEST_SKIP:
-			skipped++;
+			skipped_tests[skipped++] = test->name;
 			break;
 		case SCX_TEST_FAIL:
 			failed_tests[failed++] = test->name;
@@ -211,6 +212,11 @@ int main(int argc, char **argv)
 	printf("PASSED:  %u\n", passed);
 	printf("SKIPPED: %u\n", skipped);
 	printf("FAILED:  %u\n", failed);
+	if (skipped > 0) {
+		printf("\nSkipped tests:\n");
+		for (i = 0; i < skipped; i++)
+			printf("  - %s\n", skipped_tests[i]);
+	}
 	if (failed > 0) {
 		printf("\nFailed tests:\n");
 		for (i = 0; i < failed; i++)
-- 
2.48.1

