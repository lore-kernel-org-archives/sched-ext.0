Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB151DDF5
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698658; cv=none; b=dl1jtlw/WWOPSTVsLCTyMviI7/add9Mnrzsgv6bkOEixUJAZErhj3TR6Zg4UuYc2+cCmsYD+WOKFhztVPHC5/t+MiH7nzhsmlqXYU+IJPcxaV88sF7bpJdszz3X+eIn85ulUL+6ymjr3oZ+yizmiMdFXAplOa935Y/ClrVAPZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698658; c=relaxed/simple;
	bh=OSapIsypgzxAwguCwLF3uHoyRFOPYISBOQuUBeBGKjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s79cA8ALr5fsRhaPg11WsHKU1bCPMuzF1hU2KqRnYhW6yEqwPldDwUWmWAwHboc+HOL5W94gvdBwlTJh4KZuSLRw0zv09xbW1aviikTg/3KeBqKfQlWfJfpE1/ZLhs7kNgN1TAWZgVrr9SAIZgs0tuUrDX92BgY1YCpp/hKTgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eE48o9oh; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE48o9oh"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fcc575709so44476725e9.3
        for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790698655; x=1791303455; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/6pvxZeKIDYo9vdlmIoyBxKuaoJZDw4e5OkPlYPYA8=;
        b=eE48o9ohNI0csmurWm4M3AvX1Fq0tscRlQn/DPC0OtA8Yb6oG5VgkoDtyXcI3qYgYY
         7AQRNUWj6tcTGbpl1sdAjIgaFc8paC6Jh2UzlV+yoWkGRZG3k1joRn70icGHxhsWNaje
         CTz8f4/uiIGpo6/TR7mCs/biKrKJ4qCB1r4YxiZyPwROSwDA+97L8y2nIieXanflgyZY
         z2myXjN+WRHDeTheHu88Fn5rU9xjSszXP8Sx07nEzDv4hg2MKEtOX1Kh3DLzQxIMn8dP
         E8ji9vikUwI5O9h+qICYyN75CkyQVIdOQdhBqawQcwRDBoM7VW5xIweCjCVCLzfGSP5E
         TZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698655; x=1791303455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/6pvxZeKIDYo9vdlmIoyBxKuaoJZDw4e5OkPlYPYA8=;
        b=ES1XcR3x5VsQnn3YF/d4WixzZabJdJ0zPvnr/tXRhFFxFqg3lLPHqFRnsgbIra8Llu
         iuaTvQgQraOobq7MhGzaCr/Dja5Fe5swbMHqgChqsOjUB37YROHGNkUZQcfhmbqeRLBv
         PyEDHtPzTEoJMpDLXy5Qj5Uftj9iUNfiqnFStv2t1v7IMq47zsmVgsYzvAXp1bVXXCah
         fbPD8ytl26ktskrhzDqFwUCrpg9U1xKY5354kGrWvqLLxVSIBMhYdtBBJpkfVYMZ2LoT
         N5FZ0QsvCHOhHU7MGD0OeOfUqcTkOMtlmoG09xLZUqsoGrq6h3vQUpWKf9heDUfwaDUV
         cGOg==
X-Forwarded-Encrypted: i=1; AKwUvBzwXNKRLTWq5W/1c/Z9D4f9atQGK65647OSWzY6+Ra88eQkeWFmYpkNkn69hVJUsoyYcMwAFxjEFdI=@lists.linux.dev
X-Gm-Message-State: AFuF++mbxmLIgypbACH5TJ3njlP7ErnqnOeKMwGbarHWHy5seknG6/os
	jy0WXiEMclUBHcTDGG3zCfT125oqxp65WV2TNstZ5tMAK+HLnkSmex3NIEAhFJzCS1yOmM0SXl6
	n/UyVenNlcq98ww==
X-Received: from wmpe40.prod.google.com ([2002:a05:600c:4ba8:b0:4a0:137d:1bc8])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b33:b0:49f:f9fa:fcfe with SMTP id 5b1f17b1804b1-49ff9fafdccmr173062125e9.13.1790698654808;
 Tue, 29 Sep 2026 09:17:34 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:17:26 +0000
In-Reply-To: <20260929161730.185271-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929161730.185271-4-jpiecuch@google.com>
Subject: [PATCH 3/3] selftests/sched_ext: Enable the dequeue_remote test
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that ops.dequeue() is called when a task arrives on a remote local
DSQ, the dequeue_remote test passes. Add it to auto-test-targets.

Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 tools/testing/selftests/sched_ext/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 4e06d0baaeec..af919a56a4f4 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -165,6 +165,7 @@ auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
 	dequeue_iter			\
+	dequeue_remote			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

