Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057A3C7E0A
	for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084562; cv=none; b=KeyH1QAOFkDlG5EKcxQQVzKkpClW/y1c9pMTTpRNTkOPM7FkcV7M7pv4ZX2DLOAyO3k0YQSPojFOl52G+kUmu+gXKIINPOnibhNukVqw09Sty+ARLqQ0rmXgwUkI9WFrvB1kg3vNCsVh25Gst2nMDy+WsX9ahD98gqZGdQ0Kso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084562; c=relaxed/simple;
	bh=Z3cNA8j/78leauxyhJJRiybcGuO1UBXlb14jOZ4l88o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hpbj5QvZC62HySUW31jQmz17262xg9PYk9CH1taq2GJbEcNGmR8D6TiPho9Up9z3hbFT9OuAaFXKPxKKhf9HJWv1z6LCWBU7RwJWQVLjP6HMlmBIeC35fy8vcpZ8qoT+A9uA+Vd045zmFLiC3ZlIQQc0eKnHq+xJkMlKsJ0ZPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WeQCSYI4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeQCSYI4"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488c74405ecso26798625e9.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Apr 2026 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776084558; x=1776689358; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYSjvFVqOb2Ff9E9WDbGz7uydXxIqYZzZiieWil8N6Y=;
        b=WeQCSYI49kRgovfr5gVh7ThR9TracNX0VIKW6pUnFuJs1C8wzdmS0hs/i+jhjOZ+zB
         W11z4tx+4sfHslu8VvKOvuDEdkmUBC4X9dk3JuhlvC5F1nGReODvh7ASB5/MxcfmUUJQ
         kImxCPANSJ2DkN9VIieJMck4JAqiUykCZ4uBFTcYU3FULhzITlvbWWhw22JTSd+Doi02
         IFC1DfxBApYm330nrih+h3NPBOUp+o5IvuiiJ3rzhcUpuQ9fwoV5/BXma2dmU4q6zABN
         RNiHaxVjPsQzjkEFNiHfFLPiHKvpeR/7535kwwYGQEL32YJtx8TpkdxA3WAip1wtOY2u
         vwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776084558; x=1776689358;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYSjvFVqOb2Ff9E9WDbGz7uydXxIqYZzZiieWil8N6Y=;
        b=F9W1QyWrVS38x8AP6md3+8jj2hzIF2IBY9zBF6rBgq7y72xtEebdq03ZAb96halVCI
         yfsqP49RPlSCY555sWpaoeXiPFxnrG5uAywW5MYOhgK61VsOIVg37nknEgDBw3WbCiZS
         Qhetpep2l0wmVXg3DqwwfnL6H0zNkjeAUps5UorS1OrA3vLl0UiI+aogYViYfVXCUHYp
         SjlxjGyDHsTcjtfY+KbxJjJZR5sTcO0uAmOMLKqH81EY7kto+APfcqd//g8EMQL/4OAH
         vtZFvaCGFzq84ctv64UiLrpW/uXyawxMWKQ3JX9XORFccpuSFVcTicYxWciT2+LPO3qR
         1gNw==
X-Forwarded-Encrypted: i=1; AFNElJ8ykQGdQWKfstNd4I0d+Q5bDoUkydi2vprf/TWrgI8jlX/C7pRNVYjSDvchj69cPd9tmNJVx/g5ldY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxHvDPRwqyVIDCCnTrSXjXmlihIFjnqt+hm0QQY0ceUPKF4T0YY
	JbJZP/OSp0XcWBOX7xrr/VUR1mRL69zr/ZjkmXh2vRJaAzOwWOIEgJwUTzumq99Z0zf+4kOScgx
	mXBJwYo+7+jqGqQ==
X-Received: from wmbdr14.prod.google.com ([2002:a05:600c:608e:b0:487:2186:fcf7])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:890e:b0:488:bd79:94d8 with SMTP id 5b1f17b1804b1-488d684331emr119278455e9.18.1776084558147;
 Mon, 13 Apr 2026 05:49:18 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:49:02 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413124902.843578-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.1] sched_ext: Make string params of
 __ENUM_set() const
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

A small change to improve type safety/const correctness.
__COMPAT_read_enum() already has const string parameters.

It fixes a warning when using the header in C++ code:

  error: ISO C++11 does not allow conversion from string literal
         to 'char *' [-Werror,-Wwritable-strings]

That's because string literals have type char[N] in C and
const char[N] in C++.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---

Not sure whether upstream cares about C++, but figured I'd send it in
anyway. Also not sure if it merits CC'ing stable (probably not?)
Would appreciate your input!

 tools/sched_ext/include/scx/enums.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/enums.h b/tools/sched_ext/include/scx/enums.h
index 8e7c91575f0b3..c3b09acce824a 100644
--- a/tools/sched_ext/include/scx/enums.h
+++ b/tools/sched_ext/include/scx/enums.h
@@ -9,7 +9,7 @@
 #ifndef __SCX_ENUMS_H
 #define __SCX_ENUMS_H
 
-static inline void __ENUM_set(u64 *val, char *type, char *name)
+static inline void __ENUM_set(u64 *val, const char *type, const char *name)
 {
 	bool res;
 
-- 
2.53.0.1213.gd9a14994de-goog

