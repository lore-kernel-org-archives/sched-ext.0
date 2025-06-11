Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984391EB39;
	Wed, 11 Jun 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676119; cv=none; b=AAP5DNqcGgUHVjhR5Vmpl8fbqTZsyKkgoMQZlEQdbQJy6GZ6NUjIlMbL8qRzRKChvZ2Prw7CSep0SYT+/Yd+LUh6iyLkw/YPpqh3elz9mLFf0GfLqsbXcv5JnThk/8jULhLtbAPzxy+CAwzmV/9tMSFUe1Jm+7fp7pdCTL+YLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676119; c=relaxed/simple;
	bh=T3uioR8cOKUz44ff/CR4gqgtIW4QxIwh9vA8/8J7Tu8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dqi5gmmjSvX4a5l8nP6/orDjYjc8j1t/lCTYejaEyJzWyHZfPnG2GiNpQWff/ae8qWNmnDXQNrnbaZEEj971JCz2KbBSvHtTno/9SvIHG34fehh7l6lu8VowZ1ncbBAQjN0xt4w/Kjke3lzqeXVb1ZiEVqNMX7EHqb1L74LPgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGJW/f8x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGJW/f8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38DFC4CEE3;
	Wed, 11 Jun 2025 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676119;
	bh=T3uioR8cOKUz44ff/CR4gqgtIW4QxIwh9vA8/8J7Tu8=;
	h=Date:From:To:Cc:Subject:From;
	b=eGJW/f8x5cyDmbi8jov2jo0dx7hRY2+bs+hY62PrcEOkedFydRtqUVuzjPTJBOpim
	 AWoQLOBinZVvPHkBUb5gd9VyIR9yN3N4Xk0Z5XLrhCd/4lHgNUQ3nUHyr0tX3UuQYJ
	 jBe9S6pW0E2kCcB5QDnsX2bAUXhFVzIpB9jXjoBajUXZ24S0Cll2BswLZxhLg5R4HF
	 JW6DeuLElGgs0k3dWUYBk6wYb+h4yv6+0ek5YuGI/GWKlH6m58TkfKlqM+9r0hfy8P
	 XXKaJErX4u8zp1BWBkQdxFhHbWproQ5i1mKy7wKnxphHhr2+VuA7ZxPyt8xgEYdg9U
	 VR8dnaSYdfxmg==
Date: Wed, 11 Jun 2025 11:08:38 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.16-fixes] sched_ext: Update mailing list
 entry in MAINTAINERS
Message-ID: <aEnwVlCeVCOdLx_d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 47096d301e39f96962ca1fd6c7b71bfa796c53db Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 11 Jun 2025 11:05:16 -1000

Use sched-ext@lists.linux.dev instead of LKML.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..8841f24d408b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22171,7 +22171,7 @@ R:	Tejun Heo <tj@kernel.org>
 R:	David Vernet <void@manifault.com>
 R:	Andrea Righi <arighi@nvidia.com>
 R:	Changwoo Min <changwoo@igalia.com>
-L:	linux-kernel@vger.kernel.org
+L:	sched-ext@lists.linux.dev
 S:	Maintained
 W:	https://github.com/sched-ext/scx
 T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
-- 
2.49.0
