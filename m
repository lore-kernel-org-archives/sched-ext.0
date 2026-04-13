Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EF30B51F;
	Mon, 13 Apr 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097316; cv=none; b=ls/hfP2z9vuz1qdxDontaIdY8g4x/OuMWuGsOW71BwSoIsbmbEtC7diM0bkFq14/c5Py+TA5tKPIye+3PU9QQxC5tYRvnfmjjWS7UHw61T6BZpnKivV7yAIZoaBdN3rzPqbKkeZxc2YHwPeXzjTF4CuB2d5zpafPbDrtCJ/0GPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097316; c=relaxed/simple;
	bh=03x6JdBOrvjMSdIr7PULY94HILofsuHaFrMNxhB5xXI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fwSdhvNHqWR99UfmeM/n0n12dK+f0cy0ze/NGcom7W29uT3FtKEL57LbjV+N7QUAkhkw2f4lxNMEF6tOELC9HzTOYED6as0E9LI+fpfIhc8tQiosNQAlqF7pMud/LTLzrWG+YBVfGoyVcCyh1Hp7J7cpggkth61+nC4SQSQZRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A435oLGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A435oLGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83329C2BCB0;
	Mon, 13 Apr 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776097316;
	bh=03x6JdBOrvjMSdIr7PULY94HILofsuHaFrMNxhB5xXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A435oLGFYMD5AdO54Gj2xS9Mkn1UxQh3pdpykT/n2hNhxEvI+Ncu0JXiJZ/ERwjT+
	 nPtp9uivIwXEPdcJgbalJrL+ZSMqS1AhpqteboewjAR7h2EFJzEYFoCULgZ8tXD5AE
	 aCMlnP/U+G8wW4S/ztww/aoUvaaw3FKIxsbXAuzJM3XMQvtfTJbC7dak2tpAHJx0Ww
	 bxjXEUslbNVxdfMT/bPciSjD1mEH//tCaL12WAqMlHHsc44Ovx5faA5I44/Ie2Plos
	 olxNntB8SV/zWDzJMfFvSDGepgDQnFqADvKMvmx6J8mE5AzYbma0PaWYVd28zfwCcy
	 LCOGpB9FgRoNg==
Date: Mon, 13 Apr 2026 06:21:55 -1000
Message-ID: <4ba9f8141f98a8ce2dcf740a905f6a06@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add explicit cast
 from void* in RESIZE_ARRAY()
In-Reply-To: <20260413155005.1215682-1-jpiecuch@google.com>
References: <20260413155005.1215682-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Kuba Piecuch (1): tools/sched_ext: Add explicit cast from void* in
>  RESIZE_ARRAY()

Applied to sched_ext/for-7.1.

Thanks.
--
tejun
