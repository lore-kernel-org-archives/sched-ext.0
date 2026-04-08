Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C239B97E
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639987; cv=none; b=tBwSLqFZf9hSVk0sPa5ubAF5btMzRxnapBBoGXK+7dWCDPfg+3FWEBbuCybbG72gweALv8Ut/0cTys9ghQWiTzFLy7nfUGIRL/kwlr0ESMpdc9DqBWd1GmBjkH+m9T8U52uOvo4dv2YFLAUjNWm/cdQitisu1ioPsvrdP30g+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639987; c=relaxed/simple;
	bh=WzEsEsduf2sQc3dKAdRwaP5aVyz8wNAQWwECTdXiTaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sa+nbDDqsPK+OysKx3GzcFaWw5xH6zoj4FVqgBUcb86g31kXD1Mj7qk2Sw2StcvDQX44NK7OIcQ94jqPNYaY2Bxi7ka7wPBX9+qjmVJ0j3523eN6+Ipt9/L+DTsNFxtx1T7Xn6ZkaIYAKboBhP7bWj6FQe5f7pKOrTofuhhpElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xwp6hZeY; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xwp6hZeY"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d121c4271so4566017f8f.3
        for <sched-ext@lists.linux.dev>; Wed, 08 Apr 2026 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775639982; x=1776244782; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6wudDjPf2Vj8w3dFyq1e1+5psQ2M5yoeUXXKSlAbWo=;
        b=Xwp6hZeYgj5CwfojVDzTq8itrj9/qXf/RIn/LzCwamDFvbqG8Gm/delUiifuQjxCIQ
         Eya6NBPF9KRrf5pcxcj/JKvp88TMTGXO8hVKPf8iZB1pvR6PCMNl0orUKXFISjGhYYB/
         4Jn6sNV3kaGEwuBmhjIpaFrMjLY83RB8V6y9o6dh3E83klnMIiC0Kcg2II1YXl/YFp+7
         W0egbM0W2wCpXeHKnXImnn8sVukPrUR0o1XJNRm1ACGNDm1O9fBZxRcBa0DKy2eKqvZD
         5PrVvPc4IfxcVCfvJnbVH3WBU26c8DlLppN0unwy85NWRYFszH0S6G9aLeEqQRWc6mPN
         6hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639982; x=1776244782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6wudDjPf2Vj8w3dFyq1e1+5psQ2M5yoeUXXKSlAbWo=;
        b=qe21IqZahyxBjnVAPLmgMhhilSay0du5XMwYG2lozyH5lBrrd9B157FNMjjOr0oS1j
         wCbGzxYD+9eA2B0ChjcvyZfKDTwLXpxH1x9G6kWUcXZFln5UVzlVhg3muxW8u2nm+8ik
         N1xJ4P1ATZT0ZyDp02gzOOJlH7isi4VX1I6Cv3f0FpcZw36wzQUf9ek9dxJ/mxg8dIey
         CjElyyPgrt5t5MD9OeS1dNPVQQLUZWzQJwJPT8Ix0oKDBHqqW+lEi+jdkHZct1OpBw88
         r/fp+XWSL7lruRojayox+JyOOBDfPtulKaxIhalaBFcOJAo18koz+fVok64xsVK8pqD+
         r9UA==
X-Forwarded-Encrypted: i=1; AJvYcCXl0XocGAqxQejkt9+uOqhKXeebgrJA0/8UQXCkvzwVDhPYHmCEYJzWx6Fn/ipzfKHTvIr8r2xz5sg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwNwOyYgMqFdHzSaP3dpxv5CBAS7tkwM6uQlX9sQxtC299kW0AI
	AET6UmPBr2lU5TbVOLlKn5eZ3pDEYrXrPwONPUGRKVbn4JTqTuf3aewWyzZCWOW8236mHeOis4l
	vGgMaV6+nz/Rl0Q==
X-Received: from wmbem21.prod.google.com ([2002:a05:600c:8215:b0:486:ff40:e138])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:894:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488aa3dfc7dmr106454015e9.17.1775639981413;
 Wed, 08 Apr 2026 02:19:41 -0700 (PDT)
Date: Wed,  8 Apr 2026 09:18:21 +0000
In-Reply-To: <adUxZ5Qp_vH6cBZj@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <adUxZ5Qp_vH6cBZj@gpd4>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408091821.91063-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing calls
 to quiescent(), runnable()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Christian Loehle <christian.loehle@arm.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

When a queued task has one of its scheduling properties changed
(e.g. nice, affinity), it goes through dequeue() -> quiescent() ->
(property change callback, e.g. ops.set_weight()) -> runnable() ->
enqueue().

The existing documentation only mentions dequeue() and enqueue() on that
path, so add the missing callbacks.

Fixes: a4f61f0a1afd ("sched_ext: Documentation: Add ops.dequeue() to task lifecycle")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 Documentation/scheduler/sched-ext.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index ec594ae8086de..b5c70f4cfc352 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -429,6 +429,11 @@ by a sched_ext scheduler:
                 /* Task property change (i.e., affinity, nice, etc.)? */
                 if (sched_change(task)) {
                     ops.dequeue(); /* Exiting BPF scheduler custody */
+                    ops.quiescent();
+
+                    /* Property change callback, e.g. ops.set_weight() */
+
+                    ops.runnable();
                     continue;
                 }
             }
-- 
2.53.0.1213.gd9a14994de-goog

