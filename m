Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072F21B196
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688476; cv=none; b=KV/5PN70Sm0Xv1epVca92rdrZbc+Ulg2U7+fkbz8xN/LcIX7Z7HLXyYT1mMxE0gODJV3IEAE1qmDprAexqEiWirAet0+iRGz/2HgS77AUzwYMQXax6uYgvEtexi3tVFN9HW9vLQjeYN7/Iy9tl5U1ek1jWYm2aDYNyg4OnTNFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688476; c=relaxed/simple;
	bh=7xsVF7zAzj5FifA36T8yjRyqpa06oTN7clUEhnrGCV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofDpZio1E1lIlmhBtHzFYXRt+ZPfZAkIkuFs1L4vDOP0sXmpqNQjqpjLSq8VFHiMPoMnEDY5Hua+VFxr7oDwAwWm4bQAToag8N/3U7V375BUihLoIpOsPdhoMNo9wmCQSrZnhdGFjmsvAiV55TcFk7Ow71G3TRS4mJTMZLxAlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFYuGBR+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFYuGBR+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8249aca0affso1588050b3a.3
        for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 07:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771688474; x=1772293274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1+JZ8nfTkgEgeeUL7DuZfmlDeOQXUWtt9vvxPe3Jc0=;
        b=cFYuGBR+9JWDHDk+FacC0HfultKxt7IYvVZmNFmpdSpuegnmamscOCEQRbeObOTEkq
         gJ+JTg+DBOMgIV6bTexWK43u93Ya56xRcVOoEK5Lbvf8Iy36gg5/fdGWEpCLGsmUwlhO
         Llj3DAk/Kbrejr3TafxQhc1cb+V7kZrObskeBg2GXQM6B3P+APE7YgaCE4frYSXwvsvd
         3oK+34nMZqIPmTyIdeRuOz+Nxws4vAe94nA5Dnm42U8bc0aNhx3Zcw2OxHo2LLKS0USh
         nGne3AqVN0IrW0FfgvvcfAnFfhkwUVo99KTR331HzIUPn+PR9nXJoyF5oecT8SQhBT4m
         DbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688474; x=1772293274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1+JZ8nfTkgEgeeUL7DuZfmlDeOQXUWtt9vvxPe3Jc0=;
        b=L9kvYeQdJ+eZBftX7Q24P7V+CVHdotVBcqi2TUmwdvRSojNnqqnelDVf8SboCq7rKY
         CbtZaeycn+uabI1ts4JKYZlaB161k+/5/ivCFYi3bhwTQNGs/59DeYpC/etIqNJb8IDi
         70SDMzTvHO5B6E5g9tlGSkkvng9aMER/pzmp2apK1Hh3M42/uO9h4pm5Hf8kSH/6QF8h
         vNnwpClv7MOizYTWhrGFa7K82gkoJNQ+RlycKguz2Lu3I2yuNL+86d6m6hnUo83A6PUH
         hsCK9QeVAm1QUUieD9AuerJa7nNBAsatycnWbuRC9fHhpdCJZ1morg4Da+I9PYgx64p5
         MlzA==
X-Gm-Message-State: AOJu0YwzcsmxxA+onUQyOlEv8agvneVh3B+C0Dj3k3XYUZhl6jxpA+5c
	a0QTu4tcrpYNr4MKrExn1G2apVzjnUMM3sg14WwT97GC8rNcAb8GLhE3LSe+Uw==
X-Gm-Gg: AZuq6aKwa4eQbgUM4RAA1fT/UZoQMqfp98MFDxsKRHtu7vt9lOc8QQ+5mi9+rq0NnSn
	Xe44jPqpLw7n85q9lgXmjAZVCFUFBhQ8/Zf8QCcnrIFb5QRi0HBVAUI+b5e5M8iE7haC4Annx2F
	bVZqU2Hywv4tkiYaGcNWfMxiwH4/Vyeezm56MbxKu+1c9ZlM38Fi0cmKIpwhFmWE8fHpU9c0sYr
	oo6KfunG8+vYXNXaXvSUSMBiL4r0KD+3uYrd3xGXbeiZFger62XYDxE0h3w5UpMUPahQdNsuXb6
	M33PbFABL15GWuwYb5nH+3UHi4xieITO5H4mbXY/kDUOIXwYPMVTvK3FwkynPYoKrff7kh4ejAf
	B03G48gXYWO46Vhg/qvqIM8u5SgjVY+EozYknm1jWFZpwQMdoZ9i0GGbV2DGPXfzTAfdrue2eoN
	hXrCOb0/CDGLO64XRN+gLZFSf8rH97ya9vmTH669KWsmUYugaFkA==
X-Received: by 2002:a05:6a00:3e0c:b0:821:8202:44e3 with SMTP id d2e1a72fcca58-826daa022fbmr3570521b3a.30.1771688474407;
        Sat, 21 Feb 2026 07:41:14 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:4f:a1e9:3b8c:51c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8c7535sm3053798b3a.56.2026.02.21.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:41:14 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] selftests/sched_ext: Abort test loop on signal
Date: Sat, 21 Feb 2026 23:40:42 +0800
Message-ID: <20260221154042.1171011-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runner sets exit_req on SIGINT/SIGTERM but ignores it during the
main loop. This prevents users from cleanly interrupting a test run.

Check exit_req each iteration to safely break out on exit signals.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/runner.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index 5748d2c69903..761c21f96404 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -166,6 +166,9 @@ int main(int argc, char **argv)
 		enum scx_test_status status;
 		struct scx_test *test = &__scx_tests[i];
 
+		if (exit_req)
+			break;
+
 		if (list) {
 			printf("%s\n", test->name);
 			if (i == (__scx_num_tests - 1))
-- 
2.48.1

