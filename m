Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E213CC7CD;
	Sun, 17 May 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041497; cv=none; b=SXO4q6FyqyPh9pATquaohnRLkaHiFuJIOFjbklRTKJ1rh73Lo+3ohMomwg6iS9zUVQWI782buvcfaXqFgKtAOFVHI0ut+f1CHOlbOBTNj3/40zTR1+gW7QsErmcBtVLQZlNWzbQywMqZDLN+gGHN25wjrZvGkN2vF+Yk3ucaKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041497; c=relaxed/simple;
	bh=spAqWbrbcQ9xpPEYQpeK948qyWQcByTL9R4kaR9akM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksnqrVeBldqT4+n9W5D2vu0WVrAmOzchisJnq6A+whoyYgKxqb2u/hrYUDvHdPcKCa2mMSWT0iJVFKuuxeqj835f5bD/fFhoPG+T7N0HcGjjldzmji9FU1G5hiiV60gjgGwnS9XdsG5D9TAiqGjx5bLlqMK2TtBms+SoOk60M/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wry6oVtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wry6oVtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036C3C2BCB0;
	Sun, 17 May 2026 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041497;
	bh=spAqWbrbcQ9xpPEYQpeK948qyWQcByTL9R4kaR9akM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wry6oVtZ4ZLHfaVXxStVdiaXaTKha1UzJInSspDbc9/Vl8TcdPS1RNs+zb42sWCZE
	 p4FJuOFMwRknHVGIuAa1Vq+UpfUbaYrnqg+eFWgTYfU3xALS7z7egnMeNj5nsGYmhQ
	 AZtV6jeAxTb2yW8Nkgm1/yU/nRkwNrDE4mlRfX2gM2JHpKkKNaghs+DcF018KpxzyB
	 X0aM3h9LiA5NbX5XVcDk24Yxw9L3lBWnfBE+j9jCtHfYLwPcHu48lcjQvZCM6s7PIf
	 EAsc4HILSTZzwnWpdXlUB6zhVchrgi3L+4oL/wa+JZJeK09GNC0XV6Myz9L0xaz+rZ
	 /PeZYv1CxK0Cg==
Date: Sun, 17 May 2026 08:11:36 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 INTERNAL] bpf/arena: Direct kernel-side access
Message-ID: <agoE2GbHxeCd_HYd@slm.duckdns.org>
References: <20260517181022.1184056-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517181022.1184056-1-tj@kernel.org>

Sorry, please ignore. This went out with the wrong head message.

Thanks.

-- 
tejun
