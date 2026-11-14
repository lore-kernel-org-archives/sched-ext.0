Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794641694;
	b=B63jBZOKYN6eplNaEIodVbJD+XU64RUdo68IjN9rz4qSVsBDqTgXakB+VVf14WyZ3zou
	 MSVDvbbrNGgbC1DCQ2Z2dKPDdeUmIEQjsZQEgz84S5Kc2IZxQW4Qy6RFQ/qKUDC2qE+vQ
	 jnoI7FqBy0JEXjCViWnFfXmqzn2P/v3b3TQ5wiqXZZ5Jo7XmBw8RZQ9tBCBN9gHuWHtt4
	 ySitYQzV1eAMIcYp0hici1zp4vCA0EYDs3vPEilZ+AeBIt4TvVyKxiWswtC08b0ndugyH
	 KMV09xGxFbewroexUmNIOwzl5VZ9jX+5QF/l9ppq+GQTxsTtC+JCD20Z8rRjCsnsohA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641694;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GRJntM954CwnT8rI30qD6SSnpdFLcDqPLA4DnHTwOM4=;
	b=TXwu8j/1TNAN+xerc76evNgh/CGWPsg5W38wxxn43Sr2O1ggIn1Jpi1G4rxcRHiVK86+
	 ZpL4p2pk8p0HQa1VOuSHs+3iLbg36TPabeHegSZxMvUQAttvOcfKDem60GXGIR9watMgz
	 a7hu+rp3Ev9PHqCK2TG4X26P9dQuU8KjetlGKVM5L7wE9cLDLweZWSgRrpEhWd3FnBGkz
	 AgesHxAjCOALr+/EcVUjCRRcATsy/lm7Byc6TBa5Qlpmbtp0loAZf/IINIk5cK+3c4AGT
	 jNZsugts8UYZ+r+rbWB9PFCjXopT923mZ0CqTLrA8WsvJqEN3CN5EUZ3Wbeh0ZJmgQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8IeW9Hg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E874606A329;
	Sat, 14 Nov 2026 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8IeW9Hg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794641693;
	b=3D5wUYqQ+OkVlx1Re5w59KKwQcohM6uFogNv+JgJxT7E5m+Pp1u3gSU/7Sdhe6I1Eyzt
	 042c0vF417+9GRz/3dugnRZX0DE7WbJkdYB+yypFxukDgjXlnSZ88lJEfHJfp/aMaNTZ+
	 pkprHJOcK3yKOMBOgZBIusRghp2PhJtNx9OK+XIjvjE8lXOMHlDMcHQlJNukn0F0SpduI
	 YVEZuBSItVoKyats6k1lAy0p5LO+5xztnsORGjH1vmz/v3+uB9QDc7zJcjXAnD9qU2fvu
	 O4y+7y40ZgZ2zOIGtwwzZOuXXCnQazeF+xcwZXPfAQM6ckIeLGxDz5A4gNsA5F9XpYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794641693;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GRJntM954CwnT8rI30qD6SSnpdFLcDqPLA4DnHTwOM4=;
	b=dxHH+5IHzcKnLZ9ZGCff8sJNFT6LpnIpPISXRWmUN5mo+FxyEaydlWcDI09gYKm6wfhQ
	 vOblMfYtgsP9mdIkP9riakgUzUuZ0lO3WRPPB27vYAzYYHi+c8sfrCiLrwr0rTxmI3+0D
	 B8RpG//BYpa1iEuC0HtG4U7L2CNLcCCeNk4tvS0DIDwxGf61YREwFXP8oN9vJo82zz6oA
	 IIZfD1DeCh0rak/nfvJnljbYfwqnZQVobIDr5v5aAaq8sHfd9Pz3ZRis/h0tiV6h9yHo9
	 X20DjO5e1KeIW0iPt4L35fwsYtwq4guVwrz8icNCXcLeZK5nys2klgIZ17oS/IuNoKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 043C31F000C8;
	Sat, 14 Nov 2026 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794641693;
	bh=GRJntM954CwnT8rI30qD6SSnpdFLcDqPLA4DnHTwOM4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=i8IeW9HgAaJuHDn47+MhDCnlRtP7w0eYmOjX/YReZt+TIujp+97qDsKAFil4iKeWi
	 pJJVGE/OT+n9XW19rOz7FIFzHVKVYgEjl/Yn8mEbVythh1YwAC7eAG53UBG35Uwne8
	 1dVaKX9mXSImhxbz76nQmyA2nFkBaCVmUg+QoWk83Zu9l4g9qM4ppcj9wxL4WukFvT
	 xDY3w26BpKGIxqQJealnvXTwkEVrL43X5EXRKTGAUatrzA0IOwMwC0XnAyHxuPdtdZ
	 GOC9KCPAHpN1BEBeJzbibokICsoPgHb7NCbWq7cEG/2ISOF99zSrrmDnB7sEEfrZcj
	 Zvgr9jaa6M92Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5878D49CCA;
	Sat, 14 Nov 2026 07:34:52 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 14:34:26 +0700
Subject: [PATCH sched_ext for-7.4-fixes] selftests/sched_ext: Measure
 rt_stall runtime over sleep window only
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261114-scx-rt-stall-v1-1-4188a9378067@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf6Xk2YgdZRV/RUSyLnWBsUlSRmHs3
 y3z8TjudjBWYYOH20F5E5N1aeAvDtJEy4dRxsbQ3breex/QUkUtaIXmGRP52Ee60xAytOSrnKW
 euydYmnh8cy0ur4rxGvDvXsfxA+cLDU93AAAA
X-Change-ID: 20261114-scx-rt-stall-ca1767a8ab4f
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794641691; l=3171;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=64ICNfU8iUX1UX4sbMTXozzlz4bDJsKLO9wf23ALotc=;
 b=7es2OxIPB/1qY7wtNWGRVEsLn9zmcDTLh5smtHVSoGjQ0sjYgYAWKrh4J2Ie0dTzNFlcQWw7G
 mKc8sNLNOnfD3v3wSuqake8zPPoh17U4mrikPpmFcwO7CyBcCkARc4u
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

In sched_stress_test(), the parent can be slow to start as it has
to wait for the DL server before reaching sleep() while the RT task
still runs. The runtime of each task is read as a total since fork
instead of during sleep(). This adds extra time to RT and makes the
ratio inaccurate which causes flaky failures on CI.

With the parent pinned to CORE_ID, the RT task had already run for
~0.95s before sleep(), so it was measured at 5.69s in a 5s window and
the EXT share dropped to ~4.2% against the 4% threshold. CI has seen
3.0-3.9%.

Measure CPU time right before calling sleep() and use deltas to get
an accurate measurement window. With the parent pinned to CORE_ID, RT
measures 4.75s and EXT share stays between 4.81% and 5.57% over 20
runs.

Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
Link: https://github.com/kernel-patches/vmtest/issues/458
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 tools/testing/selftests/sched_ext/rt_stall.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index a1552b38a6e8..0c6403d25298 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -149,7 +149,7 @@ static bool sched_stress_test(bool is_ext)
 	const float expected_min_ratio = 0.04; /* 4% */
 	const char *class_str = is_ext ? "EXT" : "FAIR";
 
-	float ext_runtime, rt_runtime, actual_ratio;
+	float ext_runtime_start, rt_runtime_start, ext_runtime, rt_runtime, actual_ratio;
 	int ext_pid, rt_pid;
 	int ext_ready[2], rt_ready[2];
 	bool ret = false;
@@ -201,6 +201,23 @@ static bool sched_stress_test(bool is_ext)
 	if (!wait_ready(ext_ready[0]) || !wait_ready(rt_ready[0]))
 		goto out_kill;
 
+	/*
+	 * The parent can be delayed before reaching sleep(). Record each task's
+	 * CPU time right before calling sleep() so only time used during the
+	 * measurement window is counted.
+	 */
+	ext_runtime_start = get_process_runtime(ext_pid);
+	if (ext_runtime_start == -1) {
+		fprintf(stderr, "Failed to read %s task runtime\n", class_str);
+		goto out_kill;
+	}
+
+	rt_runtime_start = get_process_runtime(rt_pid);
+	if (rt_runtime_start == -1) {
+		fprintf(stderr, "Failed to read RT task runtime\n");
+		goto out_kill;
+	}
+
 	/* Let the processes run for the specified time */
 	sleep(RUN_TIME);
 
@@ -218,6 +235,8 @@ static bool sched_stress_test(bool is_ext)
 		goto out_kill;
 	}
 
+	ext_runtime = ext_runtime - ext_runtime_start;
+	rt_runtime = rt_runtime - rt_runtime_start;
 	/* Verify that the scx task got enough runtime */
 	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
 	fprintf(stderr, "%s task ran %.3fs, RT task ran %.3fs (%.2f%% of runtime)\n",

---
base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
change-id: 20261114-scx-rt-stall-ca1767a8ab4f

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


