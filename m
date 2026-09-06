Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F9D30C16D
	for <sched-ext@lists.linux.dev>; Sun,  6 Sep 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704172; cv=none; b=E80OngGuru/JZob+c+v8o7UqYEOpaNsJaAMU+eWzaQI2mkXRZ73Uf3t+lHZ+GtuECe1IwHYDZ7X9NBteGyKzgxqwHLOFRDQFeBTxxSu4/BCSFDjb6bOdjHYs0uZLb2CpgWF0x7Do8qV2UKjckvuCJVWhezUJtV/1vB+lRmcuUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704172; c=relaxed/simple;
	bh=kBziXRb4xkro2U105NfHH7Bc5Xtf9RDCbcH+RfIsoKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESgeJwOBZqM4piswylObISDFqWufIps46MgBjh3ZqPMWD2JnTbttszJ9tls8b5FiNm2jxlc+LbWr+66S2oTsToIdHRDfrSkPYIk1oiNpxTxV45SbCwmzhDG26Yiy7QbWlyqWlB6YkrHQms0W1tu1D6Br/Qq0mRktRvyPnnCF9KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=nIQTjkzh; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="nIQTjkzh"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdBY20MYsz8sWS;
	Sun, 06 Sep 2026 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788702921;
	bh=71YrgSHuZLndedm9wwmiiZbkg6WKcS9DSEAI9LncDTA=;
	h=From:To:Cc:Subject:Date:From;
	b=nIQTjkzhP3mMxcgtv6hVEzKICczIiefvHU4djych37cg90+VGYIyc0ou8z5MaugC8
	 Re6WO/iM60BC1ZcJXWNeOZyHgRYWhzni1+3yuGX0Tqf2sItqkrcQ6CC21V/NifByuv
	 MrcyMewg9qJSrw7VoetNH3jNb9BbwiDm/hsNE2GcYRPTvFXx5zyarQ35UvttyJcUQm
	 lldSXbHfRuaFd3nN/tL/TZD0eOfcuh3g/PBTuM74ddRAIhKtdV63r161tvUtW7lnZx
	 kxsdTEEJxAlGF8wc+JMuM1GMPHv/nCxrxdAvTFi/lgaHnf27WNKoh4xq9EJLncVD43
	 MBQm2xpamxSqA==
From: Tianyi Chen <hi@tychen.cc>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH] selftests/sched_ext: Fail interrupted test runs
Date: Sun,  6 Sep 2026 21:54:55 +0800
Message-ID: <20260906135507.749280-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

SIGINT and SIGTERM set exit_req, causing the runner to stop before
executing the remaining tests. However, the exit status only reflects
the number of failed tests, so an interrupted run returns success when
none of the completed tests failed.

Include exit_req in the failure condition so callers can distinguish
an interrupted run from a successful run. Keep the result counts
limited to the tests that actually ran.

Tested the actual runner under GDB, delivering each signal before the
first test and after the example test passed. The original runner
returns 0 in all four cases; the fixed runner returns 1. Normal -h,
-l and -t example invocations still return 0.

Fixes: 9d851afa4826 ("selftests/sched_ext: Abort test loop on signal")
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/testing/selftests/sched_ext/runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index c264807caa9..57dda75384f 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -243,7 +243,7 @@ int main(int argc, char **argv)
 			printf("  - %s\n", failed_tests[i]);
 	}
 
-	return failed > 0 ? 1 : 0;
+	return failed > 0 || exit_req ? 1 : 0;
 }
 
 void scx_test_register(struct scx_test *test)
-- 
2.55.0

