Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAE2D7DE4
	for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903690; cv=none; b=fgWuup1051LuCcn3mwwEpe9f0P6qDvQB7liGPYgbAWP777rZyOKHqwrn6qIZmDFhh9h/1yhhyaIz8Yj/nlbe4k0e3ldfFLSBT9Ukxo18LSkDjD/ZSLh21F1XWaZAIY+W0mA4c/IG9jqQvkVv1dh3Mync1BmvO0IR+ZncagDCxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903690; c=relaxed/simple;
	bh=a+qtgi1u0E/yy3Arqhj+x2XegoAvgyWn/ESgIzxc2zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSiI7MDHdrCx4MsrJ5k/nUHPpqR+aBzesMktO+obwu51ma4ZnhfTRQlUZRVqrVMZx72QzKeaB8TY9PXj309wWQYa8gps+T82v1QQM6akPDw9sLoNCqCIZUajb+3/nzW3dn6mWZZ9jTIzOIzZVTkdTeCEClNZZFzbSHRFY2YGvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgnOQrJi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgnOQrJi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso387348b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 19 Mar 2026 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773903688; x=1774508488; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QLtLSIXaJatdS6h1ESraQjK+5WjYv2k4bMTmGiD7wQ=;
        b=dgnOQrJi2FHOlAIcri1zulwO6S4gvwsK7gT24heiAthvg7sAzbKUimHNooUAFcsjsi
         PVWGYOYNnmlJjP/8g3wmDRSDcfdwzE6o3N93TIpq5SRqqgbSoyr8E66Op5B84MxH4wog
         vEB1w4JiXNVs2C3X3ikWTMN4Ox2M0B6sdLdr7byUAvWbdpWbMFisuByUy8RlNBPwYOfS
         +JVgkYbpgLtzcbuxuqeb/mh0P9zHKLoQqmnacldevZospJqPaO7d4AcO/CUcGB+ctpl2
         tm7lPRQLM1bPV/5IQuXE0s80mD9lTzwlxvktDrl6KeO6sAcF8gu0uKyKGyMUuFIp/HyK
         bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773903688; x=1774508488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QLtLSIXaJatdS6h1ESraQjK+5WjYv2k4bMTmGiD7wQ=;
        b=RfrQN9DXQ1PfI1UiwwPzNv2pxRRj4bmMazqM2oGGy6QlNd1vsU3nl8wbbFv+oY2x30
         XOPhzb4yZ350QLZgCa4uIvNxw/3/KDgUFsZTe9AApmNk9YiiEDKahInEgpdSm+L4P9qp
         TlInTjWo6FFazPslnODVZiWyBDRefM0d8WgLUxkTca4AKiiibMyGiz5RE3JX1uE8XQ7z
         lw5be1BiI01NP0924gP+1GLOFfiM7WkHcyGKnWn+T1M6fv/XicnZvDBNeDRRlgUnsLC9
         enSpYiDGHqNgXoPOn8VP+j66BwxHUubT22aCGue/GzDmxXjS3XMZSwx+0vgfMnGJq6cQ
         WfVw==
X-Gm-Message-State: AOJu0Yy2nQo/y528WZH4kL3yIDUoERkzkRGhyq4MvlRIEP0NS67KZXEX
	YRtqtN8GZ+t7PLBtUZZaXO5s8nmIBwn8nPkao77cDLzocYrSe31eABJl6ra4wQ==
X-Gm-Gg: ATEYQzzWGu2clgA5i4g2NqKJJuAXs4m3tn4aaM9k2qWJNHWYDzjLqjtul7EjUTHAtEA
	ivNLUEfwEJ9RhlqovWesci4u60R/5IC8ZMdogu7Vi1+g3WUJzoRDJz0B1ym8KYnud/NDfj1E/RO
	v4339myx9Stt4r4JEpiIZO+TpXZVhzpaQ6pRJZxQycXy+0cvRuUBs+ygBg54O9OQOWDqcGBRhW9
	JHF2+ZeTOMoMxVj7o6U2c2tFjB5Hvr/m137xyjmCU8NMBtiyVDQzU0cnsiEHqlkqH110612VCse
	RHDfF/6BXBD1LAADiKIj2O44Kq5TKksaJ2YksskNbyhWp4pXgFbrWWzt7xXoWEsRo5GTCNen04I
	4w8Ys0deB4XcvyfxkZ6+1eoLe0O3vkL+zB+NbfsbnjnvarO2l4YGGvUfeZ7Hs8GjiHgMFRAfMpX
	As9NzUNbXD5pf3F8bvLypKUjp7vGbGzJ/6tpJeWOnj9ZG82Xnrb/8hyiTY12VrDhJbDHhshqFS3
	Tc=
X-Received: by 2002:a05:6a00:8c02:b0:82a:64c7:8c6d with SMTP id d2e1a72fcca58-82a6ae1f450mr5386765b3a.25.1773903687959;
        Thu, 19 Mar 2026 00:01:27 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm6599578b3a.43.2026.03.19.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:01:27 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: Su Zhidao <soolaugust@gmail.com>,
	zhidao su <suzhidao@xiaomi.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 2/2] selftests/sched_ext: Return non-zero exit code on test failure
Date: Thu, 19 Mar 2026 15:01:19 +0800
Message-ID: <20260319070119.575316-3-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319070119.575316-1-suzhidao@xiaomi.com>
References: <20260319053026.447892-1-suzhidao@xiaomi.com>
 <20260319070119.575316-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <soolaugust@gmail.com>

runner.c always returned 0 regardless of test results.  The kselftest
framework (tools/testing/selftests/kselftest/runner.sh) invokes the runner
binary and treats a non-zero exit code as a test failure; with the old
code, failed sched_ext tests were silently hidden from the parent harness
even though individual "not ok" TAP lines were emitted.

Return 1 when at least one test failed, 0 when all tests passed or were
skipped.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
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

