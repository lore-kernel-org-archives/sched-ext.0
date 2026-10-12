Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311F41167F
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806398; cv=none; b=eahfCxjoTjhoOggTYVpiqlQRe80J5h5jCUcNoH6zAu8iAfJYEauVhOpj+H0xs2uzj5wU5XXgAIre5w7wcxPDaoFs/EGYKAKXO6jdFDYhjkcPkQ5TqrHKNYv/ClGzZYEef87i3Mp3SOzFbxshEvjLg5glHGN4mvtkmZ4k+IaNi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806398; c=relaxed/simple;
	bh=EzDpsgtlAsM6sEVEfKYi3/y6Sp/FTY/YZWERXcc1OI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUmWUrK4ASQlN0TrqzEuMAdaPEuReuu2Kj0tzcvlQKzAcsGiohxEyDKSI2EGibTNcaP8WTS3z5AufCF5sN1St5bq3Dy7vUMivQx32XP/pXd/WVYf6LXXZ2G6WkVfmhJTvj+cFPvh8rVrfr4Tv5ekO/cKVIpC1UzFvlH63rL94vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hZjrjcjE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hZjrjcjE"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 32A2C809C0;
	Mon, 12 Oct 2026 13:59:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mPi9Y3gFAcpm; Mon, 12 Oct 2026 13:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791806392; bh=EzDpsgtlAsM6sEVEfKYi3/y6Sp/FTY/YZWERXcc1OI8=;
	h=From:To:Cc:Subject:Date;
	b=hZjrjcjEW5q73/TYJLtI3Q1eHw3Wmp5hO69Uk+ULbgYcNbjSzJX5Ex2Pz9ckRqvRu
	 RXGbKKHhiWhO7vG/PU7gIeujCcgVkB2/Jj9bnO7UiQ3eM4t9Oqz6Pwo58gUVTugtrs
	 H7gNxZBuiWic0+zPPKpOnO5uRDWaOtb3xVLd4rE0tNenRF6j97VFSHh4sw48UM4+05
	 A+gFPeo75oBC3wcECg/2uzPXJ+j9UcXzJ8xP5Qk1j+pf1UcRppPot7CxeyWUwiaIFa
	 KFyYNaE2obPzHKAiYIuGhCuUUki+zwxhJZHX9iqF8+nZLucqoh+g25gFrzuGxTbQFG
	 Y9s8hmkMn9gdQ==
From: Samuele Mariotti <smariotti@disroot.org>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jpiecuch@google.com,
	shuah@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>
Subject: [PATCH] selftests/sched_ext: Fix build error in dequeue_remote selftest
Date: Mon, 12 Oct 2026 13:59:28 +0200
Message-ID: <20261012115928.1372317-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building the dequeue_remote selftest with newer compilers (e.g., gcc 16)
triggers the following error:

dequeue_remote.c:39:32: error: variable ‘sum’ set but not used

The 'volatile' qualifier prevents the writes from being optimized away,
but does not silence the warning, since 'sum' is indeed only written and
never read.

Consume 'sum' via an empty asm() with a register input constraint, as
already done for the dequeue selftest in commit 3788e3251653
("selftests/sched_ext: Fix build error in dequeue selftest"). This forces
the compiler to keep the accumulated value (preserving the CPU stress loop)
and avoids the build error.

Fixes: cc07fae1de5d ("selftests/sched_ext: Add a test for ops.dequeue() on remote local DSQ moves")

Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
---
 tools/testing/selftests/sched_ext/dequeue_remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/testing/selftests/sched_ext/dequeue_remote.c
index f2c1901030de..af344581d5f1 100644
--- a/tools/testing/selftests/sched_ext/dequeue_remote.c
+++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
@@ -43,6 +43,7 @@ static void worker_fn(int id)
 
 		for (j = 0; j < 20000 + id * 1000; j++)
 			sum += j;
+		asm volatile("" : : "r"(sum));
 		if (id & 1)
 			usleep(100);
 		else
-- 
2.56.0

