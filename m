Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C737284880
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898237; cv=none; b=GgWB9MZ2Jn5iRgaMrLlTPSG9NM3VbaQaktJySL/8TMTbMucwNtOPSm3gZBcDe3PEr5YUjXbfm0rpWGtuiC3j/mMFnTPUxsofn7UPFDpCrjAOPb1OLKpaB4VmhSs/v5+hC7gT9CrJB4NQJsnuEa8F1xKbZH9cXM92oA3Gvyn/ph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898237; c=relaxed/simple;
	bh=deZCArAxAgW18n0QK1G4xj/+c1cDE1iWbgPzytcH9OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRQrt1GKnvMD1GPC/tQsYNvilT3/vzBVOmt0SYR4rqjXiNALOrf+BrfXkpM3aTtaLzKSwF2VaXiZ18pSNhDHgrazXkGEIKkYAhvNq6mrYFIajGtGXrw9MetyeZFh9Zh4VtLHTeErmOJUun3rnQoxigm4tWXFYvB5YjAoXpIlOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg0/b295; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg0/b295"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296d553142so284579b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773898235; x=1774503035; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAi+67qjV+s3HTAw/2DtT4bt1ATgbjbqG60VseIeN9U=;
        b=jg0/b295XE0b4RUKHaddYOjbLvy71zO2XBuksd0s45gBQR0OzIfb86ibtE4uWomkYB
         4K9iiTZskOxV2fKGAk0R+gTZat6diacHQYz00bKBG40np3Iskqh8/Idiir/A30EGO7fK
         js4tWWayKTYIECABE+lRIiS6EgnjQRg1od4tQ9JHjjDI8TlLP6zrN2P9fF9ftRjnSrlc
         JBgA1u7aV6c9WaO72s18lfTRBkJ2oCfmjPcea4nIp9BUhC1Tm0rNOXFCS/2j82UpaVnz
         gklaVud0adCmfXRpWUEmXaTiEfdngfvdvKIpfv8Fz5NygnPzWKGIGwbtfP0DB3YB/g4H
         wEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898235; x=1774503035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAi+67qjV+s3HTAw/2DtT4bt1ATgbjbqG60VseIeN9U=;
        b=Q5G84LSuxagucjsLrVm0xxnp2QOXnNhKqNdtgtJdJ2BX9Az5j4v2/Ht41mZCXriasl
         x2LJJ7zy5nqQy/Ggk0urdBSXrINn83fesoscJc20+qR/VDx/RaEJJ3TAHTV3hJ6XDR4g
         gtpyknqgVqFEtDRFL5IolQHFbjThIe+fWcfF31Ta9U5DBgVey5PnkMRey+ci8iosJESz
         RN20zNtQ+5YIrTseVMAhylBCql4I+vYLoycoAy2+HNLczi/yfihJBcf4nLPC4GygQzXD
         Kt1VguKWmlqVuEgLhpQEfeYP6szeXnxFfJy6RYy5nMc4RIMw8AHn1zuWwXjYv9pjWk8T
         TIYg==
X-Gm-Message-State: AOJu0YyQgIdwrrliMkDTAPUkHp3GDYizk0CwyY2HMuWHpBjg5sbKBuU9
	8lawUXEc44OUXNlAJS13/7CwuZ+biMt9adSx+K1EuqOCzrwDwhKx966glajxIQ==
X-Gm-Gg: ATEYQzz49cA8h/wcEXv+xhy9UGjDzi45AhEZH9EtdlIBuY7aKbJFUuM2HBsfxrLz0il
	vQginJBeFshAyBknAXC94+KJQkIbn8vlsLu+Wmzinqoy3BA/XQfHIRa2VUtyvEcOEw0rus3G4OC
	H8VM32U1OtQnP0GHA3tn2FVAmLhtAcTZsiQGinGqG8jbZa75R9mjWCtTuRegPyYpW7CdojHczwG
	x+p00QL+Mj3o+/yp0tJdFMBZCRuM/57AznqsWVibrwFKcGcTCtZku8oEalIIckr+JmgnFlcUtPM
	HNwJ/YMJVi/1c6wbWVNJ8TzgIeSqWaeFWZFokb1BiqTLxnYxR43DiTGyL86XTlFeOnALjoUEdc7
	eJHQPNmbsbhd0YkcEqJb/D4OMjGRrdswuZRWvpc6S9rRSvr+31EJDzC7kQyw179IjSbVOuLO9Tk
	jsz7n3J73JV2McmZwyVkF2lQpaTmrw9ipCYrJ5mCcYwBygvrBzvOi89f6CO/EsgmdAGlK1K4S5P
	ps=
X-Received: by 2002:a05:6a00:1ad2:b0:81f:1a4b:bf50 with SMTP id d2e1a72fcca58-82a6aed7ee4mr5355645b3a.36.1773898235312;
        Wed, 18 Mar 2026 22:30:35 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b532155sm5488403b3a.7.2026.03.18.22.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:30:35 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 2/2] selftests/sched_ext: Return non-zero exit code on test failure
Date: Thu, 19 Mar 2026 13:30:26 +0800
Message-ID: <20260319053026.447892-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319053026.447892-1-suzhidao@xiaomi.com>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

runner.c always returned 0 regardless of test results.  The kselftest
framework (tools/testing/selftests/kselftest/runner.sh) invokes the runner
binary and treats a non-zero exit code as a test failure; with the old
code, failed sched_ext tests were silently hidden from the parent harness
even though individual "not ok" TAP lines were emitted.

Return 1 when at least one test failed, 0 when all tests passed or were
skipped.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/testing/selftests/sched_ext/runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
index 37ad56c3eb29..4c68efa1512a 100644
--- a/tools/testing/selftests/sched_ext/runner.c
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 			printf("  - %s\n", failed_tests[i]);
 	}
 
-	return 0;
+	return failed > 0 ? 1 : 0;
 }
 
 void scx_test_register(struct scx_test *test)
-- 
2.43.0

