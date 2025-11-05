Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B62BEC42;
	Wed,  5 Nov 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380189; cv=none; b=H5oplYHRWbC4qdvCbrVHz3MfbTsqx7+ophO2G8HLgLE/1SPXrnD4C+7xDsjmOdt83q45CzDLwXFAS7/UBlNyIcHA3HXsqs35IZ0yFbrKPGyds64cB2mBLIkOd8UyRBPRO7OG9w3ZrGMRha840RF8yAukyfQqCXPXvoldTv6Fk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380189; c=relaxed/simple;
	bh=AnWwGKeQooPlYbUr+C0sojh6f1NXESUu5BAJbuwV6bE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=roqZhU6fE2DwLYXatsu229KzVItT0DyxCXl9JyF9iaGIfpE3Qd8M78AkfREd19552ZbQlPwM/eoO7Y+Ikc7IK4lvZywIbHdWDNTTv/RdRkebhrolQKXhmuG2CKjlchQrVYhPKJE9osVSiAKLF/7W82n4BEKICN6ELtHy05hEiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiLtOvai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiLtOvai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BFC4CEF5;
	Wed,  5 Nov 2025 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762380189;
	bh=AnWwGKeQooPlYbUr+C0sojh6f1NXESUu5BAJbuwV6bE=;
	h=Date:From:To:Cc:Subject:From;
	b=LiLtOvaiNRgD/8yTO9mnsIKRu1IllaXug4hoXmqUj3TND8dJRxNmLyV8bKF3cAtk0
	 wFmlWrJ9Rc4Z+vkfmCspDDeJwtnd892dAd2Bzcf/MLWnRTxLYNtzNJ+hneDuG1hsJj
	 sKjTuuKKnNFYrNlXOrhYKR2MwzgWte8+x7HPqcwzTklwebIXo5S4lRsrFJu2qZCwFG
	 VNDpYmSTz01TSMiBeuZwmESabNWQisFhBwkoSqpz89aFaGCufQ1PTRNBbfBZgP8ACm
	 RREODHCbCWtnydMiB8rhTTI0JAtr3pbyI+ttsMb2pHZo5RHePWQc5MKd6k5Lp68CGS
	 kn7F4K/1TLYew==
Date: Wed, 05 Nov 2025 12:03:08 -1000
Message-ID: <5d2305143c29ed781438acc9b92fb781@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19] sched_ext: Mark racy bitfields to prevent adding fields that can't tolerate races
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The warned bitfields in struct scx_sched are updated racily from concurrent
CPUs causing RMW races, which is fine for these boolean warning flags. Add a
comment marking this area to prevent future fields that can't tolerate racy
updates from being added here.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_internal.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -895,6 +895,10 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;

+	/*
+	 * Updates to the following warned bitfields can race causing RMW issues
+	 * but it doesn't really matter.
+	 */
 	bool			warned_zero_slice:1;
 	bool			warned_deprecated_rq:1;

