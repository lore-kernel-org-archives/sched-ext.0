Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55F33C52F
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584183; cv=none; b=RlgsdTpgAppHIg5quY+g35DWaBdd+LnRqXhkS6EYFcuA1GbHjq5qV3GCnwlBjM2Jy6SuHFE+5dlpX6jiW/2NhDGz7kaJV9QpdoPzsIauGNKrSu/jtyMLopaSYnaep6KdrB1dTbKo4UBxNl8pnu0ZUIpJdnnPRU+8DqgsqAoZmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584183; c=relaxed/simple;
	bh=YKIzLPow/0YNMfc+RmUfwEr3oGDY0oELLJAMy6vyrPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0L4Lfe5fsyNhf7OXRrTQtNJ5EUFEAzpdiiXNukIFW5jl6xaV0eLE1zTNGHyFO/mBxI7Xb2uJa9XHlxlV5zguVxScPBn8mb1V60JsqbceGZfOaFlhYxKWkbeZmGsDpgXJo23XXVBBOs6kitjsdyqYZ48XdkSn7AxXrCetQm4Pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htl24NN6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htl24NN6"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82ce49785a0so2255297b3a.2
        for <sched-ext@lists.linux.dev>; Tue, 07 Apr 2026 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775584175; x=1776188975; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMzvn2h8zBTNQVjllCS+BG9y+8/VZD+7TFdchUY45qY=;
        b=Htl24NN62y2dxyjOnWcNRLoSioq/gScUgcxvkSzXUW3kCHg1JcIa22jSCne/iVF1i0
         J2JughFjg63jJAmp5RIKICyX8QZkRko3Ig6ZDj/MjSktndugMW4b8F6RrJ/JIpVXcq5U
         SRD0pneEmptO38zmwgcLR0tfHcMasKVfBH7eDUB+mTKG8Pp/og5T5Z1WTA/WxfWC+0v5
         PITVHyNDn3EqECnrvT2UKsHHzxSbImEFku5NLwDyb7NY8+ADfYrw2OWYOXCkvBVaE5E7
         STMOQPXaznRiVIUqviBWpFWbkmLISnoqi1cxFG/muH49CjBT/MB3LKV04FZsv78RZsOt
         dtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584175; x=1776188975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMzvn2h8zBTNQVjllCS+BG9y+8/VZD+7TFdchUY45qY=;
        b=k2Qou1Push15f/mRlUZD75LDo3oy5jA/FsgVUoHgf7glBNIp83hE63Hjo3cMLZ3eA3
         ydz1FfvBoFXslleuctDRZlUgnPOFzrK7yu6H4/nHSl7JfdsnwHfmFYVmxqSXKWGuAKmN
         Ge94gNGYKn1arB4id37E/oNuBQ/6WnJOhTvnzFVPOTjCb4oJHcEBechyUNsanWSXz8v8
         sAsply3u8hOMFdZObBl2rH218QqO3bl8BK8TX0nm4E5UdtNA7t5BfHrDmdhuYXpYEOTY
         XWgZeT0pr/oBYobPypowGjZoDgvWJZq9tpkXsJMhETrS5TVZPj4/8IhcFCamYGCBHaGm
         DRyw==
X-Gm-Message-State: AOJu0YwqJg2VgfxRCMUTIsO0BDW41PEbW6DsQbmZaCwUJ5Dp+ia+l5it
	sd8XKuUlMKr95kR5sO2rxCmzNGUr20FdTWxp7SPMadU0naq221QgvNVijnCRag==
X-Gm-Gg: AeBDietfVFcjWlBL6b2Y4W2e5O9nCLcqnRIxj7kb6eCzkcmSi7qRRfGTYBBrWt51cY3
	FEJbXYSavKFLKVD4eq/olIKaVRPnWnTyRdOmP6iMZF/2vvLTzD7cz0CEaaIW6r4ixjfIUJUQRPA
	H/jNmeJv6VMoZHRjbn3ENSjkKZeybqQLeYHVM9oECkulPE5SrdH1ci2tXB2k3Kht/tU4qOPI8Ut
	F9pOo0lhiUfeT4CRbczhfyhEFtsx7Yg1cKP+epjJK0clkLsM+yHndNMeVPYRP6cGY1u9ApuKKO7
	lXsxGTYx8FR0SODhv8f1YgYqsnkwac+RfE6RYyce9ZaawfLpOGUYZ9qsalGiHcxfQNs0NujFqsw
	BbVgswPzKpIx8G+hJPs+w6UMRhXgt2mHPjpX2rnRoo/5CUz7XMKvoK6t30XWxQNMRW5UcBE2Kbj
	snPHQWvNHlAqk/OItcnZxUzJD+Tbdd7n+Ff9PflSsGe4I6oOJiKWrx
X-Received: by 2002:a05:6a00:1d9e:b0:82c:e19d:cabd with SMTP id d2e1a72fcca58-82d0da2afbcmr17065621b3a.10.1775584174575;
        Tue, 07 Apr 2026 10:49:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:4c23:8546:f68d:c612])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm19429341b3a.11.2026.04.07.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:49:33 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1] selftests/sched_ext: Improve runner error reporting for invalid arguments
Date: Wed,  8 Apr 2026 01:49:02 +0800
Message-ID: <20260407174912.3156824-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report an error for 'sudo ./runner foo' (positional arg instead of -t)
and for 'sudo ./runner -t foo' when the filter matches no tests.

Previously both cases produced no error output.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/runner.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index d84f71eee049..e5640841cbfd 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -164,6 +164,12 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (optind < argc) {
+		fprintf(stderr, "Unexpected argument '%s'. Use -t to filter tests.\n",
+			argv[optind]);
+		return 1;
+	}
+
 	for (i = 0; i < __scx_num_tests; i++) {
 		enum scx_test_status status;
 		struct scx_test *test = &__scx_tests[i];
@@ -207,6 +213,15 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
+
+	if (filter && testnum == 0 && !exit_req) {
+		fprintf(stderr, "No tests matched filter '%s'\n", filter);
+		fprintf(stderr, "Available tests (use -l to list):\n");
+		for (i = 0; i < __scx_num_tests; i++)
+			fprintf(stderr, "  %s\n", __scx_tests[i].name);
+		return 1;
+	}
+
 	printf("\n\n=============================\n\n");
 	printf("RESULTS:\n\n");
 	printf("PASSED:  %u\n", passed);
-- 
2.48.1

