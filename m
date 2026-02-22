Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF95A930
	for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771786064; cv=none; b=goJSibJcPpK4caVs7DPMKeHFTvazht42zlCsrbsb1PdBul2bVFUp/ura38PwpojD5P/eIsrUCRR5RY7wnCbRPBy9Hvlc6ZoBysTkM81NOJyKbhhZr0sciJpwa9Uo/WwXTRVZUUuhNtK0td6qFHT7t5yysuNVxmlweRFQy9GN7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771786064; c=relaxed/simple;
	bh=4Q3chkiBki0wcuFdCXeJ3HzUAgrDavWyuuZZxF89uxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS1yxusoRqcA/zjAHRTUwahDc15JylfL6bCznX8SO4ZmQqOJ0jCE1bhowUi3c7Ee2r1w2C2I1jOjH4qumsnMBncO9P5wReTzGczaoh5KyE6ZdzCgmx9AP1KN/wwQwuPHQcuE6KykbvKq88H/ZFoRIiLHvj5ELqRHo6S1mMjsNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPjembPx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPjembPx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso23279975ad.0
        for <sched-ext@lists.linux.dev>; Sun, 22 Feb 2026 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771786062; x=1772390862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw3GDbcsgrGPpiVf0mR4Tetvdj6YV5es8I0bUF96NH4=;
        b=YPjembPxqbpznzgpWiPMf4Mf3bzYel8uZtKEN0iz9ygOFFCKuaphUBMdfYnjTDs8c5
         jWESI+aI5lDOrjU08sSvaoIxPQBNSRHJA1Z96sJGiiqvq2IBK/+k11BWOc3hcD5CjHmL
         WAlMoySwFPszXDRudNOb9JhjurIiZAGRH8itblq+jzQx598WAckyIzGX0fY3aIRSuSnv
         CYfjfUeI44YtFkS+A1+rzYGnic2eQVD62NwadLd2D0qRKbb9EAiqTPfpPjLmB/K4aJn2
         0Y2enffeE5qrCe/1NSG4qNurFyH6IPoG5MePpbF/G+iabFhKu3Gh+XPlLPWmUuFCHd4R
         fVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771786062; x=1772390862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw3GDbcsgrGPpiVf0mR4Tetvdj6YV5es8I0bUF96NH4=;
        b=wD0bldGrpA5xqcmrpCb8fMvQlpEMOq2cZT43Net+Pyb7qklx8gCxi5Y7taPzgmwkq+
         xIPYR09NxN/3nhLr1sd45oMPGcIQs5GeRnGNc8XiGnEB7VaYVgy+zzgqLBObE/cV08un
         YN1N2NAHvOFW59UP64C/jng1HP7oY0vg5JPo5smCo0E9hD7Mho5R+tX45HMzFNYQDvCX
         yFepikyF7j/PuMxdkUe4wo7jXVDPAbRzxV+ftZtMXNKfYkpPGsoj8b+YPJkixR9QjvcI
         ojbCnjUvRsdCmNPZLDD/3UbZDEwYV+UQy+inOEehBacoKs85Fyahc2FqQWnjFvbc1bqJ
         OssQ==
X-Gm-Message-State: AOJu0YwIJFFaDsu1wL4TiIPpazSsrNOqkf0/ChxnHyjoCdE+MDMZ4Z7T
	r+ucsP8bZgQ94Tr07F4l1CQtWscq8Q+nGStuMxmtiRo/qI1/uyJYXDRVKgRktw==
X-Gm-Gg: AZuq6aIlilzGlNfa77PwOPhoUlSwU35Nclc7swA144ndwlqvEguopNysQJLiq6aULt4
	lGM3UM14DBxBzIZVMO4MRZQ2qOzTj2OiSRAfCK/DusVNbX4I2zOYnTTsXijq4Gw37e89YKR7TC3
	6415J/MxrJiNHe0Eqi6jd2hkHobnKa0IgQMwx3qbc0XEEPGn8CFGIwYnRwE4V9WlL3KXQiYEkVF
	MH6+TlTARJ2H+pMggNJYhwnBY3nf5CIqDMEXiVRc5kIU5t/OMgmDTEyf6qyUr7MnjaDAudQGcu5
	RAVZEor8YFuV5ddscdUuXEB2ZbsyWG6cXgmBiUsEexe4PXW6hqp6G3LBsU31R2njE8SaaO6LlPx
	TMg7BOsNxm6SUPLFTNJ0IBy2CXn6Lw7RX/K2SEAW3qpcU5MYCsP5erSGQH4YkuQOG4DKap1WoNS
	1T7wTvQWUfztORczHB5ZmsqRO0moN8JZYR+mnWqL6I9G/09QKn8r93
X-Received: by 2002:a17:902:ebc3:b0:2aa:3ec2:3774 with SMTP id d9443c01a7336-2ad7449e424mr50687165ad.16.1771786062344;
        Sun, 22 Feb 2026 10:47:42 -0800 (PST)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:f3c7:b896:5ac6:4be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34fd0sm48571785ad.14.2026.02.22.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 10:47:42 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH] selftests/sched_ext: Remove duplicated unistd.h include in rt_stall.c
Date: Mon, 23 Feb 2026 02:47:09 +0800
Message-ID: <20260222184709.99764-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header <unistd.h> is included twice in rt_stall.c. Remove the
redundant inclusion to clean up the code.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/rt_stall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index ab772e336f86..81ea9b4883e5 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -15,7 +15,6 @@
 #include <signal.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
-#include <unistd.h>
 #include "rt_stall.bpf.skel.h"
 #include "scx_test.h"
 #include "../kselftest.h"
-- 
2.48.1

